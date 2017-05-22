//
//  MainViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

import RxDataSources

//#if !RX_NO_MODULE
import RxSwift
import RxRealm
import RxCocoa
//#endif


class MainViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let rx_dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RLMRecorder>>()
    
    convenience init(viewModel: MainViewModel) {
        self.init(nibName: "MainViewController", bundle: Bundle.main)
        
        
        self.rx
            .viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.configRx(viewModel: viewModel)
            })
            .disposed(by: disposeBag)
        self.rx
            .viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
    
    lazy var addBtn: UIButton = {
        $0.setImage(UIImage(named: "add"), for: .normal)
        return $0
    }(UIButton())
    
    
    var header: MainHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        fd_prefersNavigationBarHidden = true
        
        addTableViewHeader()
        addAddBtn()
        fetchDataFromServe()
        configUI()
    }
    
    
    private func configUI() {
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(RecordCell.self)
        tableView.register(GroupCell.self)
        rx_dataSource.configureCell = { ds, tv, idx, item in
            let cell = tv.dequeueCell(RecordCell.self, for: idx)
            cell.recorder = item
            return cell
        }
    }
    
    func configRx(viewModel: MainViewModel) {
        
        // MARK: - Out
        
        tableView.rx
            .modelSelected(RLMRecorder.self)
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        addBtn.rx
            .tap
            .bind(to: viewModel.addButtonClicked)
            .disposed(by: disposeBag)
        
        
        
        // MARK: - In
        
        viewModel.section.asObservable()
            .bind(to: tableView.rx.items(dataSource: rx_dataSource))
            .disposed(by: disposeBag)
        
        viewModel.itemSelectedAction.asObservable()
            .subscribe(onNext: { [weak self] (vm) in
                let vc = RecorderrDetailController(viewModel: vm)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        viewModel.presentAddRecorderViewModel
            .subscribe(onNext: { [unowned self] (vm) in
                let vc = AddRecorderController(viewModel: vm)
                let nav = UINavigationController(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchDataFromServe() {
        let serveIsChanged = true
        if serveIsChanged {
            HoneybeeKind.fetchAllKinds()
            HoneybeeColor.fetchAllColors()
            HoneybeeIcon.fetchAllIcons()
            HoneybeeIncome.fetchAllIncomes()
        }
    }
    
    deinit {
        print("MainViewController ---deinit")
    }
    
    
}



// -----------------------------------------------------------------------------
// MARK: Popover
// -----------------------------------------------------------------------------
extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popView(btn: UIButton) {
        let destVC = MainPopController()
        destVC.modalPresentationStyle = .popover
        guard let popoverVC = destVC.popoverPresentationController else {
            return
        }
        popoverVC.backgroundColor = .white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        present(destVC, animated: true, completion: nil)
        
        destVC.incomeBtnAction = {
            print("income")
            
        }
        destVC.expendBtnAction = {
            print("expend")
        }
    }
}



// -----------------------------------------------------------------------------
// MARK: UI
// -----------------------------------------------------------------------------
extension MainViewController {
    
    func addTableViewHeader() {
        header = MainHeader(height: 205)
        header.tapContainerViewAction = { [weak self] in
            self?.navigationController?.pushViewController(PieViewController(), animated: true)
        }
        header.usernameAction = { [weak self] in
            self?.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        header.rightButtonAction = { [weak self] btn in
            self?.popView(btn: btn)
        }
        tableView.tableHeaderView = header
    }
    func addAddBtn() {
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.height.equalTo(60)
            make.bottom.equalTo(view.snp.bottom).offset(-20)
        }
    }
}




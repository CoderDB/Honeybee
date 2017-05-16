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


class MainViewController: BaseViewController, UITableViewDelegate {
    let disposeBag = DisposeBag()
    let rx_dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RLMRecorder>>()
    convenience init(viewModel: MainViewModel) {
        self.init()
//        self.init(nibName: nil, bundle: nil)
        
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
    
    let tableView = UITableView()
    
    var header: MainHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        fd_prefersNavigationBarHidden = true
        
        addTableView()
        addTableViewHeader()
        addAddBtn()
        
        configUI()
    }
    
    
    private func configUI() {
        rx_dataSource.configureCell = { ds, tv, idx, item in
            if let cell = tv.dequeueReusableCell(withIdentifier: "\(RecordCell.self)", for: idx) as? RecordCell {
                cell.recorder = item
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func configRx(viewModel: MainViewModel) {
        
        // MARK: - Out
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        addBtn.rx
            .tap
            .subscribe(onNext: { [unowned self] in
                let vc = AddRecorderController()
                let nav = UINavigationController(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        
        
        // MARK: - In
        
        viewModel.section.asObservable()
            .bind(to: tableView.rx.items(dataSource: rx_dataSource))
            .disposed(by: disposeBag)
        
        
//        Observable.collection(from: recorders)
//            .bind(to: tableView.rx.items(
//                cellIdentifier: "\(RecordCell.self)",
//                cellType: RecordCell.self)
//                ) { _, model, cell in cell.recorder = model }
//            .disposed(by: disposeBag)
//        
//        
//        Observable.collection(from: recorders)
//            .map { $0.reduce(0) { $0.0 + Int($0.1.money) } }
//            .subscribe { [unowned self] (event) in
//                self.header.outMoneyLabel.text = "\(event.element ?? 0)"
//            }
//            .disposed(by: disposeBag)
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
    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.bottom.equalTo(view)
        }
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(RecordCell.self)
        tableView.register(GroupCell.self)
    }
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




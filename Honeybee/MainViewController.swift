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

//import RxDataSources

//#if !RX_NO_MODULE
import RxSwift
import RxRealm
import RxCocoa
//#endif

extension UITableView {
    func applyChangeset(_ changes: RealmChangeset) {
        beginUpdates()
        deleteRows(at: changes.deleted.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        insertRows(at: changes.inserted.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        reloadRows(at: changes.updated.map { IndexPath(row: $0, section: 0) }, with: .automatic)
        endUpdates()
    }
}

extension UICollectionView {
    func applyChangeset(_ changes: RealmChangeset) {
        self.performBatchUpdates({ [unowned self] in
            self.deleteItems(at: changes.deleted.map { IndexPath(item: $0, section: 0) })
            self.insertItems(at: changes.inserted.map { IndexPath(item: $0, section: 0) })
            self.reloadItems(at: changes.updated.map { IndexPath(item: $0, section: 0) })
        }, completion: nil)
        
//        self.performBatchUpdates(<#T##updates: (() -> Void)?##(() -> Void)?##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//        deleteItems(at: changes.deleted.map { IndexPath(item: $0, section: 0) })
//        insertItems(at: changes.inserted.map { IndexPath(item: $0, section: 0) })
//        reloadItems(at: changes.updated.map { IndexPath(item: $0, section: 0) })
    }
}



class MainViewController: BaseViewController, UITableViewDelegate {
    
    
    lazy var addBtn: UIButton = {
        $0.setImage(UIImage(named: "add"), for: .normal)
//        $0.frame = CGRect(x: (HB.Screen.w - 60) * 0.5, y: HB.Screen.h - 80, width: 60, height: 60)
        return $0
    }(UIButton())
    
    
    let tableView = UITableView()
//    let rx_datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, RLMRecorder>>()
    private let bag = DisposeBag()
    var recorders: Results<RLMRecorder>!
    var header: MainHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        fd_prefersNavigationBarHidden = true
        
        addTableView()
        addTableViewHeader()
        addAddBtn()
        
        configRx()
    }
    
    func configRx() {
        tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
//        let currentMonth = Date().month
        recorders = Database.default.all(RLMRecorder.self)
//            .filter { $0.month == currentMonth }
        
        
        Observable.collection(from: recorders)
            .bind(to: tableView.rx.items(
                cellIdentifier: "\(RecordCell.self)",
                cellType: RecordCell.self)
                ) { _, model, cell in cell.recorder = model }
            .disposed(by: bag)
        
        
        Observable.collection(from: recorders)
            .map { $0.reduce(0) { $0.0 + Int($0.1.money) } }
            .subscribe { [unowned self] (event) in
                self.header.outMoneyLabel.text = "\(event.element ?? 0)"
            }
            .disposed(by: bag)
        
        tableView.rx
            .itemSelected
            .map { [unowned self] (idx) in
                self.recorders[idx.row]
            }.subscribe(onNext: { [unowned self] (model) in
                let detailVC = RecordDetailController(model: model)
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: bag)
        
        addBtn.rx
            .tap
            .subscribe(onNext: { [unowned self] in
                let vc = AddRecorderController()
                let nav = UINavigationController(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            })
            .disposed(by: bag)
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
//        notiToken?.stop()
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
            //            let data = Database.manager.allPayout()
            //            print(data)
            //            self.dataSource = MainDataSource(items: data, vc: self)
            
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
//        header.outMoneyLabel.text = totalPayText()
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




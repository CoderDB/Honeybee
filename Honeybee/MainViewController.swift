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
import ObjectMapper


class MainViewController: BaseTableViewController {
    
    var dataSource: Results<RLMRecorderSuper>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var destVC: UIViewController = {
        let vc = UIViewController()
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 70, height: 60)
        vc.view.backgroundColor = .white
        return vc
    }()
    lazy var topBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        btn.setTitle("仅支出", for: .normal)
        btn.setTitleColor(HB.Color.nav, for: .normal)
        btn.titleLabel?.font = HB.Font.h6_medium
        return btn
    }()
    lazy var botBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 30, width: 70, height: 30))
        btn.setTitle("仅收入", for: .normal)
        btn.setTitleColor(HB.Color.nav, for: .normal)
        btn.titleLabel?.font = HB.Font.h6_medium
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        addTableView()
        addAddBtn()
//        resuest()
        dataSource = fetchData()
    }
    
    func resuest() -> List<RLMRecorderSuper> {
        let path = Bundle.main.path(forResource: "recorder", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let jsonObj = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
        let jsonDic = jsonObj["recorders"] as! [[String: Any]]

        let superRecorders = List<RLMRecorderSuper>()
        for json in jsonDic {
            let recorder = Mapper<RLMRecorderSuper>().map(JSON: json)
            superRecorders.append(recorder!)
            
            DatabaseManager.manager.add(model: recorder!)
        }
        return superRecorders
    }
    
    
    func fetchData() -> Results<RLMRecorderSuper> {
        return DatabaseManager.manager.allData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: UIPopoverPresentationControllerDelegate
extension MainViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
// MARK: Popover
extension MainViewController {
    func popView(btn: UIButton) {
        guard let popoverVC = destVC.popoverPresentationController else {
            return
        }
        destVC.view.addSubview(topBtn)
        destVC.view.addSubview(botBtn)
        topBtn.addTarget(self, action: #selector(topBtnClicked), for: .touchUpInside)
        botBtn.addTarget(self, action: #selector(botBtnClicked), for: .touchUpInside)
        popoverVC.backgroundColor = .white
        popoverVC.delegate = self
        popoverVC.sourceView = btn
        popoverVC.sourceRect = btn.bounds
        popoverVC.permittedArrowDirections = .up
        present(destVC, animated: true, completion: nil)
    }
    func topBtnClicked() {
        print("___top____")
    }
    func botBtnClicked() {
        print("___bot____")
    }
}


// MARK: UI
extension MainViewController {
    func addTableView() {
        tableView.snp.updateConstraints { (make) in
            make.top.equalTo(view).offset(20)
        }
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let header = MainHeader(height: 205)
        header.tapContainerViewAction = { [unowned self] in
            self.navigationController?.pushViewController(PieViewController(), animated: true)
        }
        header.usernameAction = { [unowned self] in
            self.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        header.rightButtonAction = { [unowned self] btn in
            self.popView(btn: btn)
        }
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        tableView.register(RecordCell.self)
        tableView.register(GroupCell.self)
    }
    func addAddBtn() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.frame = CGRect(x: (HB.Screen.w - 60) * 0.5, y: HB.Screen.h - 80, width: 60, height: 60)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        view.addSubview(addBtn)
    }
    func addBtnClicked() {
        let nav = UINavigationController(rootViewController: CardViewController())
        present(nav, animated: true, completion: nil)
    }
}


// MARK: UITableViewDatasource
extension MainViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        if model.style == "group" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GroupCell.self)") as! GroupCell
            cell.delegate = self
            cell.dataSource = dataSource[indexPath.row].recorders
            tableView.rowHeight = CGFloat(cell.tvHeight + 33 + 24)
            return cell
        } else {
            tableView.estimatedRowHeight = 75
            tableView.rowHeight = UITableViewAutomaticDimension
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordCell.self)") as! RecordCell
            if !dataSource[indexPath.row].recorders.isEmpty {
                cell.recorder = dataSource[indexPath.row].recorders[0]
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        if model.style != "group" {
            let detailVC = RecordDetailController()
            detailVC.model = dataSource[indexPath.row].recorders[0]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MainViewController: GroupCellDelegate {
    func didSelected(model: RLMRecorder) {
        let detailVC = RecordDetailController()
        detailVC.model = model
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


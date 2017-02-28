//
//  MainViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height


class MainViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var dataSource = [RecorderSuperModel]()
    
    
    lazy var destVC: UIViewController = {
        let vc = UIViewController()
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 70, height: HonybeeConstant.rowHeight)
        vc.view.backgroundColor = UIColor.white
        return vc
    }()
    lazy var topBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        btn.setTitle("仅支出", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h6
        return btn
    }()
    lazy var botBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 30, width: 70, height: 30))
        btn.setTitle("仅收入", for: .normal)
        btn.setTitleColor(HonybeeColor.main, for: .normal)
        btn.titleLabel?.font = HonybeeFont.h6
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        dataSource = fetchData()
        
        addTableView()
        addAddBtn()
    }
    
    func fetchData() -> [RecorderSuperModel] {
        let path = Bundle.main.path(forResource: "recorder", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let jsonObj = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
        let jsonDic = jsonObj["recorders"] as! [[String: Any]]
        
//        var recorders = [Recorder]()
        var superRecorders = [RecorderSuperModel]()
        
        
        for item in jsonDic {
            let model = RecorderSuperModel(dict: item)
            superRecorders.append(model!)
            
//            let model = Recorder(dict: item)
//            recorders.append(model!)
        }
        return superRecorders
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
        popoverVC.backgroundColor = UIColor.white
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
        tableView.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(20)
            make.left.right.bottom.equalTo(view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let header = HeaderView()
        header.tapContainerViewAction = { [unowned self] in
            self.navigationController?.pushViewController(PieViewController(), animated: true)
        }
        header.usernameAction = { [unowned self] in
            self.navigationController?.pushViewController(SetupViewController(), animated: true)
        }
        header.filterAction = { [unowned self] btn in
            self.popView(btn: btn)
        }
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        tableView.register(RecordCell.self)
        tableView.register(SectionCell.self)
        tableView.register(RecordLiteCell.self)
    }
    func addAddBtn() {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "add"), for: .normal)
        addBtn.frame = CGRect(x: (ScreenW - HonybeeConstant.rowHeight) * 0.5, y: ScreenH - 80, width: HonybeeConstant.rowHeight, height: HonybeeConstant.rowHeight)
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        view.addSubview(addBtn)
    }
}


// MARK: UI Event
extension MainViewController {
    func addBtnClicked() {
        let nav = UINavigationController(rootViewController: CardViewController())
        present(nav, animated: true, completion: nil)
    }
}


// MARK: UITableViewDatasource
extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        
        
        if model.style == "group" {
            let models = dataSource[indexPath.row].recorders
            
            tableView.rowHeight = CGFloat(models!.count * 100)
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell") as! SectionCell
            cell.delegate = self
            cell.dataSource = models
            
            return cell
        } else {
            tableView.estimatedRowHeight = 75
            tableView.rowHeight = UITableViewAutomaticDimension
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell") as! RecordCell
            cell.recorder = dataSource[indexPath.row].recorders![0]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        if model.style != "group" {
            let detailVC = RecordDetailController()
            detailVC.model = dataSource[indexPath.row].recorders![0]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MainViewController: SectionCellDelegate {
    func didSelected(row: Int) {
        print(row)
        
    }
}


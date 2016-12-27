//
//  SetupViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 30/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "设置"
        addNavRightItem()
        addTableView()
        addTableHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addNavRightItem() {
        let completeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        completeBtn.backgroundColor = UIColor.red
        completeBtn.setTitle("完成", for: .normal)
        completeBtn.addTarget(self, action: #selector(rightItemAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: completeBtn)
    }
    func rightItemAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func addTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    func addTableHeader() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 150))
        view.backgroundColor = UIColor.orange
        let imgView = UIImageView(frame: CGRect(x: (ScreenW-100) * 0.5, y: 25, width: 100, height: 100))
        imgView.image = UIImage(named: "add")
        view.addSubview(imgView)
        tableView.tableHeaderView = view
        
    }

}

// MARK: UITableViewDataSource
extension SetupViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = "test"
        return cell!
    }
}



// MARK: UITableViewDataSource
extension SetupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("----\(indexPath.row)")
    }
}

//
//  SectionCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 09/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit


protocol SectionCellDelegate: class {
    func didSelected(row: Int)
}


class SectionCell: UITableViewCell {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = HonybeeFont.h4_number
        label.text = "2月10日"
        return label
    }()
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HonybeeFont.h7
        label.text = "星期二"
        return label
    }()
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.isScrollEnabled = false
        tv.rowHeight = 60
        tv.backgroundColor = UIColor.white
        tv.separatorStyle = .none
        tv.register(RecordLiteCell.self)
        return tv
    }()
    weak var delegate: SectionCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = HonybeeConstant.cornerRadius
        layer.borderWidth = 2
        
        backgroundColor = UIColor.white
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 10
            newFrame.size = CGSize(width: frame.width-20, height: frame.height-20)
            super.frame = newFrame
        }
    }
    
    func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(tableView)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        weekdayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom)
            make.left.equalTo(dateLabel.snp.left)
            make.right.equalTo(weekdayLabel.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}


extension SectionCell: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordLiteCell.self)") as! RecordLiteCell
        cell.category.text = "测试"
        cell.number.text = "-888"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(row: indexPath.row)
    }
}

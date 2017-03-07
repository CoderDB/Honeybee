//
//  GroupCell.swift
//  Honeybee
//
//  Created by Dongbing Hou on 11/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import RealmSwift


protocol GroupCellDelegate: class {
    func didSelected(model: RLMRecorder)
}


class GroupCell: UITableViewCell {
        
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = HB.Font.h4_number
        return label
    }()
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = HB.Font.h7
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
    weak var delegate: GroupCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layer.cornerRadius = HB.Constant.cornerRadius
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
    
    
    var tvHeight = 60
    var dataSource: List<RLMRecorder>? {
        didSet {
            tvHeight = dataSource!.count * 60 + 10
            tableView.snp.updateConstraints { (make) in
                make.height.equalTo(tvHeight)
            }
            tableView.reloadData()
        }
    }
    
    func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(weekdayLabel)
        contentView.addSubview(tableView)
        
        dateLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
        }
        weekdayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom)
            make.left.equalTo(dateLabel)
            make.right.equalTo(weekdayLabel)
            make.height.equalTo(tvHeight)
        }
    }
}

// MARK: UITableViewDataSource
extension GroupCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(RecordLiteCell.self)") as! RecordLiteCell
        let model = dataSource?[indexPath.row]
        cell.model = model
        
        dateLabel.text = model?.monthDay
        weekdayLabel.text = model?.weekday
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(model: dataSource![indexPath.row])
    }
}

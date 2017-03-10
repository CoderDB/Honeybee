//
//  DateView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit


protocol DateViewProtocol: class {
    func selected(date: String)
}

class DateView: UIView {
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.backgroundColor = .white
        dp.datePickerMode = .dateAndTime
        dp.timeZone = TimeZone.current
        dp.locale = Locale(identifier: "zh_CN")
        dp.setDate(Date(), animated: true)
        dp.minuteInterval = 30
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    weak var delegate: DateViewProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    @objc private func datePickerValueChanged(_ picker: UIDatePicker) {
        delegate?.selected(date: "\(picker.date)")
    }
    

}

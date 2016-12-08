//
//  DateView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import SnapKit

class DateView: UIView {
    
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .dateAndTime
        dp.timeZone = TimeZone.current
        dp.locale = Locale(identifier: "zh_CN")
        dp.setDate(Date(), animated: true)
        dp.minuteInterval = 60
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func datePickerValueChanged(_ picker: UIDatePicker) {
        print("-----\(picker.date)")
    }
    

}

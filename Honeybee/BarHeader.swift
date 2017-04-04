//
//  BarHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts

class BarHeader: UIView {

    weak var axisFormatDelegate: IAxisValueFormatter?
    
    convenience init(height: CGFloat, numbers: [Double]) {
        self.init(height: height)
        barView.data = createData(numbers: numbers)
    }
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        axisFormatDelegate = self
        let gradientLayer = CAGradientLayer.gradient(colors: [UIColor(rgb: [248, 185, 81]), UIColor(rgb: [252, 91, 107])])
        gradientLayer.frame = CGRect(x: 10, y: 0, width: HB.Screen.w-20, height: frame.height)
        gradientLayer.cornerRadius = HB.Constant.cornerRadius
        layer.addSublayer(gradientLayer)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var barView: BarChartView = {
        let barV = BarChartView()
        
        barV.noDataText = "暂无数据"
        barV.chartDescription = nil
        
        // xAxis
        barV.xAxis.drawAxisLineEnabled = false //不显示x轴
        barV.xAxis.drawGridLinesEnabled = false // 不显示竖格线
        barV.xAxis.labelPosition = .bottom
        barV.xAxis.labelTextColor = .white
        
//        barV.xAxis.labelCount = 30
        barV.xAxis.axisMinimum = 0
//        barV.xAxis.axisMaximum = 30
//        barV.xAxis.axisRange = 10
//        barV.xAxis.spaceMin = 1
//        barV.xAxis.spaceMax = 30
//        barV.xAxis.axisLineColor = .black
        barV.xAxis.labelTextColor = .black

        
        barV.fitBars = false
        
        // x, y轴双击都不缩放
        barV.scaleXEnabled = false
        barV.scaleYEnabled = false
//        barV.extraLeftOffset = 30
//        barV.setExtraOffsets(left: 100, top: 0, right: 0, bottom: 0)
        barV.leftAxis.enabled = false
        barV.rightAxis.enabled = false
        barV.legend.enabled = false
//        barV.isUserInteractionEnabled = false
        return barV
    }()
    
    func createData(numbers: [Double]) -> BarChartData {
//        let days = Date.days(year: 2017, month: 4)
//        print(days)
//        for i in <#items#> {
//            <#code#>
//        }
        
        let numbers = [4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879]
        var dataEntries: [BarChartDataEntry] = []
        
//        let dataEntry1 = BarChartDataEntry(x: 1, y: 135)
//        let dataEntry2 = BarChartDataEntry(x: 2, y: 235)
//        let dataEntry3 = BarChartDataEntry(x: 3, y: 335)
//        let dataEntry4 = BarChartDataEntry(x: 4, y: 435)
//        let dataEntry5 = BarChartDataEntry(x: 5, y: 535)
//        dataEntries.append(dataEntry1)
//        dataEntries.append(dataEntry2)
//        dataEntries.append(dataEntry3)
//        dataEntries.append(dataEntry4)
//        dataEntries.append(dataEntry5)
//        for i in stride(from: 0, to: limit, by: 1) {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: numbers[i])
//            dataEntries.append(dataEntry)
//        }
        
        for i in 0..<numbers.count {
            let x = Double(i)
            let entry = BarChartDataEntry(x: x, y: numbers[i])
            
            dataEntries.append(entry)
        }
        let dataSet = BarChartDataSet(values: dataEntries, label: nil)
        dataSet.drawValuesEnabled = true //显示条形柱的值
        dataSet.valueTextColor = .black
        dataSet.valueFont = HB.Font.h6_number
        dataSet.colors = [UIColor(rgb: [252, 234, 203])] //条形柱颜色
        
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.3
    
        barView.xAxis.valueFormatter = axisFormatDelegate
        return data
    }
    
    
    func setupUI() {
        addSubview(barView)
        barView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20).priority(HB.Priority.mid)
            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self)
        }
        
//        let unitsSold = [4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879]
//        barView.data = createData(numbers: unitsSold)
    }
}

extension BarHeader: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        var value = value
        if value.isZero {
            value = 1.0
        }
        return "\(Int(value))日"
    }
}

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

    
    convenience init(height: CGFloat, numbers: [Double]) {
        self.init(height: height)
        barView.data = createData(numbers: numbers)
    }
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    weak var axisFormatDelegate: IAxisValueFormatter?
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
        
//        barV.leftAxis.drawZeroLineEnabled = false
//        
//        
//        // xAxis
        barV.xAxis.drawAxisLineEnabled = false      //不显示x轴
        barV.xAxis.drawGridLinesEnabled = false     // 不显示竖格线
        barV.xAxis.labelPosition = .bottom
        barV.xAxis.labelTextColor = .white
//        barV.xAxis.drawLabelsEnabled = true        // x轴坐标值是否绘制 default true
        
        
//        barV.leftAxis.axisMinimum = 0
        
//        barV.xAxis.labelCount = 30
//        barV.xAxis.axisMinimum = 0
//        barV.xAxis.
//        barV.xAxis.axisMaximum = 30
//        barV.xAxis.axisRange = 10
//        barV.xAxis.spaceMin = 1
//        barV.xAxis.spaceMax = 30
//        barV.xAxis.axisLineColor = .black
//        barV.xAxis.labelTextColor = .black

        
//        barV.fitBars = false
        
        // x, y轴双击都不缩放
//        barV.scaleXEnabled = false
//        barV.scaleYEnabled = false
//        barV.extraLeftOffset = 30
//        barV.setExtraOffsets(left: 100, top: 0, right: 0, bottom: 0)
        barV.rightAxis.enabled = false
        
        barV.leftAxis.enabled = false
        barV.leftAxis.drawGridLinesEnabled = false // leftAxis 横线
        barV.leftAxis.drawLabelsEnabled = false  // leftAxis 坐标值
        barV.leftAxis.drawZeroLineEnabled = false
        
        barV.drawValueAboveBarEnabled = true // 条形柱的值显示在条形柱上发

        barV.legend.enabled = false
//        barV.isUserInteractionEnabled = false
        return barV
    }()
    
    func createData(numbers: [Double]) -> BarChartData {
//        let days = Date.days(year: 2017, month: 4)
//        print(days)
//        for i in 0..<days {
//            
//        }
        
        let numbers = [4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879]
        var dataEntries: [BarChartDataEntry] = []

        
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
        //
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

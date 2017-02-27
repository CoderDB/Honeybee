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

    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer = CAGradientLayer.gradient(colors: [UIColor(rgb: [248, 185, 81]), UIColor(rgb: [252, 91, 107])])
        gradientLayer.frame = CGRect(x: 10, y: 0, width: ScreenW-20, height: frame.height)
        gradientLayer.cornerRadius = HonybeeConstant.cornerRadius
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
        barV.xAxis.labelTextColor = UIColor.white
        barV.xAxis.valueFormatter = IndexAxisValueFormatter(values: (1..<31).map{"\($0)日"}) //x轴label值的显示样式
        barV.xAxis.labelCount = 10
        
        // x, y轴双击都不缩放
        barV.scaleXEnabled = false
        barV.scaleYEnabled = false
        
        barV.leftAxis.enabled = false
        barV.rightAxis.enabled = false
        barV.legend.enabled = false
        barV.isUserInteractionEnabled = false
        return barV
    }()
    
    func createData(numbers: [Double]) -> BarChartData {
        var dataEntries: [BarChartDataEntry] = []
        for i in stride(from: 0, to: 30, by: 1) {
            let dataEntry = BarChartDataEntry(x: Double(i), y: numbers[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = BarChartDataSet(values: dataEntries, label: nil)
        dataSet.drawValuesEnabled = true //显示条形柱的值
        dataSet.valueTextColor = UIColor.black
        dataSet.valueFont = HonybeeFont.h6_number
        dataSet.colors = [UIColor(rgb: [252, 234, 203])] //条形柱颜色
        
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.5
        return data
    }
    
    
    func setupUI() {
        addSubview(barView)
        barView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20).priority(HonybeePriority.mid)
            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self)
        }
        
        let unitsSold = [4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879]
        barView.data = createData(numbers: unitsSold)
    }
}

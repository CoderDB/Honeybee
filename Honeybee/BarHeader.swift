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

    
    convenience init(height: CGFloat, data: [Int: Double]) {
        self.init(height: height)
        barView.data = createData(data: data)
    }
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    weak var barDataSetValueFormatterDelegate: IValueFormatter?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axisFormatDelegate = self
//        barDataSetValueFormatterDelegate = self
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
        barV.xAxis.drawAxisLineEnabled = true      //不显示x轴
        barV.xAxis.axisLineColor = .white
//        barV.xAxis.axisLineDashPhase = 5
//        barV.xAxis.yOffset = -50
        
        barV.xAxis.drawGridLinesEnabled = false     // 不显示竖格线
        barV.xAxis.labelPosition = .bottom
        barV.xAxis.labelTextColor = .white
//        barV.xAxis.drawLabelsEnabled = true        // x轴坐标值是否绘制 default true
        
        
//        barV.leftAxis.axisMinimum = 0
        
//        barV.xAxis.labelCount = 30
//        barV.xAxis.axisMinimum = 0
//        barV.xAxis.axisMaximum = 30
//        barV.xAxis.axisRange = 10
//        barV.xAxis.spaceMin = 1
//        barV.xAxis.spaceMax = 30
//        barV.xAxis.axisLineColor = .black
//        barV.xAxis.labelTextColor = .black

        
//        barV.fitBars = true
        
        
        // x, y轴双击都不缩放
        barV.scaleXEnabled = false
        barV.scaleYEnabled = false
        
        
        
        barV.rightAxis.enabled = false
        
        barV.leftAxis.enabled = false
        barV.leftAxis.drawGridLinesEnabled = false // leftAxis 横线
        barV.leftAxis.drawLabelsEnabled = false  // leftAxis 坐标值
        barV.leftAxis.drawZeroLineEnabled = false
        
        barV.drawValueAboveBarEnabled = true // 条形柱的值显示在条形柱上发

        barV.legend.enabled = false
        
        barV.isUserInteractionEnabled = false
        return barV
    }()
    
    func createData(data: [Int: Double]) -> BarChartData {
        
        var dataEntries: [BarChartDataEntry] = []

//        let dict = [1: 180, 2: 280, 3: 30, 4: 600, 5: 380, 28: 1080]
        
        for d in data {
            let entry = BarChartDataEntry(x: Double(d.key), y: Double(d.value))
            dataEntries.append(entry)
        }
        let dataSet = BarChartDataSet(values: dataEntries, label: nil)
        dataSet.drawValuesEnabled = true //显示条形柱的值
        
        dataSet.valueTextColor = .black
        dataSet.valueFont = HB.Font.h6_number
//        dataSet.valueFormatter = barDataSetValueFormatterDelegate
        dataSet.colors = [UIColor(rgb: [252, 234, 203])] //条形柱颜色
        
        
        let barData = BarChartData(dataSet: dataSet)
        barData.barWidth = 0.5
        
        //
        barView.xAxis.valueFormatter = axisFormatDelegate
        return barData
    }
    
    
    func setupUI() {
        addSubview(barView)
        barView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20).priority(HB.Priority.mid)
            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self)
        }
    }
}

extension BarHeader: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))日"
    }
}

//extension BarHeader: IValueFormatter {
//    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
//        return value.isZero ? "" : "\(value)"
//    }
//}

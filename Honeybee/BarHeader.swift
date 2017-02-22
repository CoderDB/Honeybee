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
        let gradientLayer = CAGradientLayer.gradient(colors: [UIColor.rgb(r: 248, g: 185, b: 81), UIColor.rgb(r: 252, g: 91, b: 107)])
        gradientLayer.frame = CGRect(x: 10, y: 0, width: ScreenW-20, height: frame.height)
        gradientLayer.cornerRadius = 10
        layer.addSublayer(gradientLayer)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var barView: BarChartView = {
        let barView = BarChartView()
        barView.fitBars = true
        
        // xAxis
//        barView.xAxis.enabled = false
        barView.xAxis.labelTextColor = UIColor.white
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map{"\($0)日"}) //x轴label值的显示样式
        barView.xAxis.drawAxisLineEnabled = false //不显示x轴
        barView.xAxis.drawGridLinesEnabled = false // 不显示竖格线
        barView.xAxis.labelPosition = .bottom
        
        // leftAxis
        barView.leftAxis.enabled = false
        
        // rightAxis
        barView.rightAxis.enabled = false
        
        // x, y轴双击都不缩放
        barView.scaleXEnabled = false
        barView.scaleYEnabled = false
        
        barView.noDataText = "请稍等"
        barView.chartDescription = nil
        
        // legend
        barView.legend.enabled = false
        
        barView.isUserInteractionEnabled = false
        return barView
    }()
    
    func createData(numbers: [Double]) -> BarChartData {
        var dataEntries: [BarChartDataEntry] = []
        
        let months: [Int] = Array(1..<20)
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: numbers[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = BarChartDataSet(values: dataEntries, label: nil)
        
        dataSet.valueTextColor = UIColor.white
        dataSet.valueFont = HonybeeFont.h6_number
        
        dataSet.drawValuesEnabled = true //显示条形柱的值
        
        
        dataSet.colors = [UIColor.rgb(r: 252, g: 231, b: 198)] //条形柱颜色
        
        let data = BarChartData(dataSet: dataSet)
        data.barWidth = 0.2
        
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
    
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        context.saveGState()
//        
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        let startColor = UIColor.red
//        let startComponents = startColor.cgColor.components!
//        let endColor = UIColor.orange
//        let endComponents = endColor.cgColor.components!
//        
//        let colorComponents = startComponents + endComponents
//        let location: [CGFloat] = [0, 1]
//        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: location, count: 2)
//        
//        let startPoint = CGPoint(x: 0, y: rect.height)
//        let endPoint = CGPoint(x: rect.width, y: 0)
//        
//        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
//        
//        context.restoreGState()
//    }


}

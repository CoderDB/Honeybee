//
//  BarView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 25/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts

class BarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var months: [Int] = Array(1..<32)
    let unitsSold = [4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 4000.0, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879, 8090.0, 4756.45, 8923.0, 1879]
    private var barView: BarChartView!
    func setupUI() {
        barView = BarChartView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 200))
        addSubview(barView)
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<months.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
        }
        
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: nil)
        let barChartData = BarChartData(dataSet: barChartDataSet)
        
//        barChartData.barWidth = 1.0
        
        barChartDataSet.drawValuesEnabled = false //不显示条形柱的值
//        barChartDataSet.barBorderColor = UIColor.black //条形柱边框颜色
//        barChartDataSet.barBorderWidth = 5 //条形柱边框宽度
//        barChartDataSet.barShadowColor = UIColor.yellow
        
        barChartDataSet.colors = [UIColor.white.withAlphaComponent(0.5)] //条形柱颜色
        
//        barChartDataSet.label = "每日消费" //条形主下方指示说明
        
        // legend
//        barView.legend.drawInside = false //指示块位置
//        barView.legend.direction = .rightToLeft
        barView.legend.form = .none
        
        // offset
        barView.extraBottomOffset = -10
//        barView.extraLeftOffset = 10
        
        barView.noDataText = "请稍等"
        barView.data = barChartData
        barView.chartDescription?.text = ""
        
        // xAxis
        barView.xAxis.labelTextColor = UIColor.white
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months.map{"\($0)"}) //x轴label值的显示样式
        barView.xAxis.drawAxisLineEnabled = false //不显示x轴
        barView.xAxis.drawGridLinesEnabled = false // 不显示竖格线
        barView.xAxis.labelPosition = .bottom
        
        // leftAxis
        barView.leftAxis.labelTextColor = UIColor.white
        barView.leftAxis.drawGridLinesEnabled = false  //当leftAxis和rightAxis的drawGridLinesEnabled都为false时，横格线才不会显示
        barView.leftAxis.drawAxisLineEnabled = false
//        barView.leftAxis.valueFormatter = IndexAxisValueFormatter(values: unitsSold)
//        barView.leftAxis.drawZeroLineEnabled = false // 如果x轴不显示，那么y轴的0线当然不会显示，所以这句可以不要
//        barView.leftAxis.drawTopYLabelEntryEnabled = false //左侧y轴的最大值label不显示
        
        // rightAxis
        barView.rightAxis.drawGridLinesEnabled = false
        barView.rightAxis.drawLabelsEnabled = false //右侧y轴不显示label
        barView.rightAxis.drawAxisLineEnabled = false //右侧y轴不显示
        
        // x, y轴双击都不缩放
        barView.scaleXEnabled = false
        barView.scaleYEnabled = false
        
        barView.isUserInteractionEnabled = false
        
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let startColor = UIColor.red
        let startComponents = startColor.cgColor.components!
        let endColor = UIColor.orange
        let endComponents = endColor.cgColor.components!
        
        let colorComponents = startComponents + endComponents
        let location: [CGFloat] = [0, 1]
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: location, count: 2)
        
        let startPoint = CGPoint(x: 0, y: rect.height)
        let endPoint = CGPoint(x: rect.width, y: 0)
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
        context.restoreGState()
    }
}

//
//  LineView.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts


class LineView: UIView {

    lazy var lineChartView: LineChartView = {
        let line = LineChartView()
        
        // x轴 xAxis
//        line.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        line.xAxis.labelPosition = .bottom
        line.xAxis.drawAxisLineEnabled = false
        line.xAxis.labelWidth = (HB.Screen.w-20)/5
        line.xAxis.labelCount = 5
        line.xAxis.spaceMax = 5
        line.xAxis.drawGridLinesEnabled = false
        
        // leftAxis
        line.leftAxis.drawGridLinesEnabled = false
        line.leftAxis.drawAxisLineEnabled = false
        line.leftAxis.drawLabelsEnabled = false
        
        
        line.chartDescription?.text = ""
        
        // y轴
        line.rightAxis.enabled = false
        return line
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        lineChartView = LineChartView(frame: CGRect(x: 10, y: 10, width: HB.Screen.w-20, height: 200))
//        addSubview(lineChartView)
//        lineChartView.backgroundColor = .yellow
//        setChart(dataPoints: months, values: unitsSold)
        
        setupUI()
        
        var months = ["Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [4000.0, 8090.0, 4756.45, 8923.0, 1879]
        
        lineChartView.data = LineViewData(dataPoints: months, values: unitsSold).data
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
//        barView.xAxis.valueFormatter = axisFormatDelegate
        addSubview(lineChartView)
        lineChartView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20).priority(HB.Priority.mid)
            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self)
        }
    }
    
//    func setChart(dataPoints: [String], values: [Double]) {
//        var dataEntries: [ChartDataEntry] = []
//        for i in 0..<dataPoints.count {
//            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
//        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: nil)
//        let lineChartData = LineChartData(dataSet: lineChartDataSet)
//        
//        
////        lineChartView.data = lineChartData
////        lineChartView.chartDescription?.text = ""
//        
//        
//        lineChartDataSet.mode = .linear
//        
//        lineChartDataSet.drawCircleHoleEnabled = false
//        lineChartDataSet.circleRadius = 5
//        
//        
//        lineChartDataSet.drawValuesEnabled = true
//        lineChartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 15)
//        lineChartDataSet.valueColors = [.red, .blue]
//        lineChartDataSet.valueTextColor = .brown
//        
//        
//        
//        lineChartDataSet.drawFilledEnabled = true
//        
//        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
//        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
//        
////        // x轴 xAxis
////        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
////        lineChartView.xAxis.labelPosition = .bottom
////        
////        lineChartView.xAxis.drawAxisLineEnabled = false
////        lineChartView.xAxis.labelWidth = (HB.Screen.w-20)/5
////        lineChartView.xAxis.labelCount = 5
////        lineChartView.xAxis.spaceMax = 5
////        
////        lineChartView.xAxis.drawGridLinesEnabled = false
////        
////        // leftAxis
////        lineChartView.leftAxis.drawGridLinesEnabled = false
////        lineChartView.leftAxis.drawAxisLineEnabled = false
////        lineChartView.leftAxis.drawLabelsEnabled = false
////        
////        
////        // y轴
////        lineChartView.rightAxis.enabled = false
//        
//        
//        
//    }

}

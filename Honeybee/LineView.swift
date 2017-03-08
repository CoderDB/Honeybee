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

    var lineChartView: LineChartView!
    
    var months = ["Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [4000.0, 8090.0, 4756.45, 8923.0, 1879]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lineChartView = LineChartView(frame: CGRect(x: 10, y: 10, width: HB.Screen.w-20, height: 200))
        addSubview(lineChartView)
        lineChartView.backgroundColor = UIColor.yellow
        setChart(dataPoints: months, values: unitsSold)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: nil)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        lineChartView.chartDescription?.text = ""
        
        
        lineChartDataSet.mode = .linear
        
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.circleRadius = 5
        
        
        lineChartDataSet.drawValuesEnabled = true
        lineChartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 15)
        lineChartDataSet.valueColors = [UIColor.red, UIColor.blue]
        lineChartDataSet.valueTextColor = UIColor.brown
        
        
        
        lineChartDataSet.drawFilledEnabled = true
        
        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        // x轴 xAxis
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        lineChartView.xAxis.labelPosition = .bottom
        
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.labelWidth = (HB.Screen.w-20)/5
        lineChartView.xAxis.labelCount = 5
        lineChartView.xAxis.spaceMax = 5
        
        lineChartView.xAxis.drawGridLinesEnabled = false
        
        // leftAxis
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = false
        
        
        // y轴
        lineChartView.rightAxis.enabled = false
        
        
        
    }

}

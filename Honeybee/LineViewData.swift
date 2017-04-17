//
//  LineViewData.swift
//  Honeybee
//
//  Created by Dongbing Hou on 17/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts

class LineViewData: NSObject {
    
    var data: LineChartData?
    
//    private weak var ivalueFormatterDelegate: IValueFormatter?
    
    
    
    // ------------------------------
    // MARK: init
    // ------------------------------
    init(dataPoints: [String], values: [Double]) {
        super.init()
//        ivalueFormatterDelegate = self
        data = createData(dataPoints: dataPoints, values: values)
    }
    
    private func createData(dataPoints: [String], values: [Double]) -> LineChartData {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: nil)
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        
        lineChartDataSet.mode = .linear
        
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.circleRadius = 5
        
        
        lineChartDataSet.drawValuesEnabled = true
        lineChartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 15)
        lineChartDataSet.valueColors = [.red, .blue]
        lineChartDataSet.valueTextColor = .brown
        
        
        
        lineChartDataSet.drawFilledEnabled = true
        
        lineChartDataSet.drawVerticalHighlightIndicatorEnabled = false
        lineChartDataSet.drawHorizontalHighlightIndicatorEnabled = false
        
        return lineChartData

    }

}

//
//  BarHeaderData.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Charts

class BarHeaderData: NSObject {
    
    var data: BarChartData?
    
    private weak var ivalueFormatterDelegate: IValueFormatter?
    
    
    
    // ------------------------------
    // MARK: init
    // ------------------------------
    init(_ source: [Int: Double]) {
        super.init()
        ivalueFormatterDelegate = self
        data = createData(data: source)
    }
    
    private func createData(data: [Int: Double]) -> BarChartData {
        var dataEntries: [BarChartDataEntry] = []
        _ = data.map {
            let entry = BarChartDataEntry(x: Double($0.key), y: Double($0.value))
            dataEntries.append(entry)
        }
        let dataSet = BarChartDataSet(values: dataEntries, label: nil)
        dataSet.drawValuesEnabled = true //显示条形柱的值
        
        dataSet.valueTextColor = .black
        dataSet.valueFont = HB.Font.h6_number
        
        dataSet.valueFormatter = ivalueFormatterDelegate
        
        dataSet.colors = [UIColor(rgb: [252, 234, 203])] //条形柱颜色
        
        let barData = BarChartData(dataSet: dataSet)
        barData.barWidth = 0.5
    
        return barData
    }


}


// ------------------------------
// MARK: IValueFormatter delegate
// ------------------------------

extension BarHeaderData: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return value.isZero ? "" : "\(Int(value))"
    }
}

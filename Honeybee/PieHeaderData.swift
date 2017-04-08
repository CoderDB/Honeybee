//
//  PieChartViewData.swift
//  Honeybee
//
//  Created by Dongbing Hou on 08/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Charts

class PieHeaderData: NSObject {
    
    var data: PieChartData?
    
    private weak var ivalueFormatterDelegate: IValueFormatter?
    
    init(names: [String], colors: [UIColor], percents: [Double]) {
        super.init()
        
        ivalueFormatterDelegate = self
        data = createData(names: names, colors: colors, percents: percents)
    }
    
    private func createData(names: [String], colors: [UIColor], percents: [Double]) -> PieChartData {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<names.count {
            let dataEntry = PieChartDataEntry(value: percents[i], label: names[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = PieChartDataSet(values: dataEntries, label: nil)
        dataSet.colors = colors
        dataSet.sliceSpace = 5.0
        
        dataSet.valueTextColor = .white
        dataSet.valueFont = HB.Font.h5_number
        
        dataSet.entryLabelFont = HB.Font.h4
        
        // IValueFormatter
        dataSet.valueFormatter = ivalueFormatterDelegate
        
        return PieChartData(dataSet: dataSet)
    }
}


// ------------------------------
// MARK: IValueFormatter delegate
// ------------------------------

extension PieHeaderData: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(value)%"
    }
}



//
//  PieViewController.swift
//  Honeybee
//
//  Created by Dongbing Hou on 26/12/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts

class PieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "支出／收入"
        view.backgroundColor = UIColor.RGB(r: 41, g: 180, b: 145)
        
        addTimePickerView()
        addPieChartView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var timePickerView: UIView!
    
    func addTimePickerView() {
        timePickerView = UIView()
        timePickerView.backgroundColor = UIColor.cyan
        view.addSubview(timePickerView)
        timePickerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(64)
            make.height.equalTo(50)
        }
    }
    
    var months = ["Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [10, 25.0, 20, 5, 40]
    
    var pieChartView: PieChartView!
    func addPieChartView() {
        pieChartView = PieChartView()
        pieChartView.backgroundColor = UIColor.brown
        view.addSubview(pieChartView)
        pieChartView.snp.makeConstraints { (make) in
            make.top.equalTo(timePickerView.snp.bottom)
            make.centerX.equalTo(view)
            make.width.height.equalTo(ScreenW-40)
        }
        
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<unitsSold.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: unitsSold[i])
            dataEntries.append(dataEntry)
        }
        
        let dataSet = PieChartDataSet(values: dataEntries, label: nil)
        
        dataSet.colors = [UIColor.gray,UIColor.cyan, UIColor.green, UIColor.darkGray, UIColor.red]
        dataSet.entryLabelColor = UIColor.yellow
        //        dataSet.sliceSpace = 1 //块之间空隙
        dataSet.xValuePosition = .outsideSlice
        dataSet.yValuePosition = .outsideSlice
        
        dataSet.valueLineVariableLength = true
        dataSet.valueLinePart2Length = 1
        dataSet.valueLinePart1OffsetPercentage = 0.85
        dataSet.valueLineColor = UIColor.white
        dataSet.valueLineWidth = 1.5
        dataSet.valueTextColor = UIColor.green
        
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.data = data
        
        pieChartView.drawHoleEnabled = false
//        pieChartView.holeColor = UIColor.red
//        pieChartView.transparentCircleColor = UIColor.blue //
//        pieChartView.holeRadiusPercent = 0 //内环
//        pieChartView.transparentCircleRadiusPercent = 0 //中环
        pieChartView.entryLabelColor = UIColor.red
        
        
//        pieChartView.rotationEnabled = false //旋转开关
//        pieChartView.maxAngle = 270
//        pieChartView.centerText = "hahah"
//        pieChartView.dragDecelerationEnabled = false
        
        pieChartView.setExtraOffsets(left: 10, top: 10, right: 10, bottom: 10)
        pieChartView.animate(xAxisDuration: 1, yAxisDuration: 1, easingX: nil, easingY: nil)
        
        pieChartView.legend.form = .none
        pieChartView.chartDescription = nil
        
        pieChartView.highlightPerTapEnabled = false
        
        
        
        
    }

}

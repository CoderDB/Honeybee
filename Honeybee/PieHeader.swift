//
//  PieHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 21/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts

class PieHeader: UIView {
    
    var months = ["Aug", "Sep", "Oct", "Nov", "Dec"]
    let unitsSold = [10, 25.0, 20, 5, 40]
    lazy var pieView: PieChartView = {
        let pie = PieChartView()
        return pie
    }()
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addPieView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addPieView() {
        addSubview(pieView)
        pieView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10).priority(HonybeePriority.low)
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
        
        dataSet.valueLineVariableLength = true      //线长度是否可变
        dataSet.valueLinePart2Length = 1            //线拐角之后的线长
        dataSet.valueLinePart1OffsetPercentage = 0.8  //线拐角之前距离圆心长度百分比
        dataSet.valueLineColor = UIColor.black      //线颜色
        dataSet.valueLineWidth = 1.5                //线宽
        dataSet.valueTextColor = HonybeeColor.main  //线末端字体颜色
        dataSet.valueFont = HonybeeFont.h4_number   // 线末端字体
        
        let data = PieChartData(dataSet: dataSet)
        
        pieView.data = data
        
        pieView.drawHoleEnabled = false
        //        pieChartView.holeColor = UIColor.red
        //        pieChartView.transparentCircleColor = UIColor.blue //
        //        pieChartView.holeRadiusPercent = 0 //内环
        //        pieChartView.transparentCircleRadiusPercent = 0 //中环
        pieView.entryLabelColor = UIColor.red
        
        
        //        pieChartView.rotationEnabled = false //旋转开关
        //        pieChartView.maxAngle = 270
        //        pieChartView.centerText = "hahah"
        //        pieChartView.dragDecelerationEnabled = false
        
        pieView.setExtraOffsets(left: 10, top: 10, right: 10, bottom: 10)
        pieView.animate(xAxisDuration: 1, yAxisDuration: 1, easingX: nil, easingY: nil)
        
        pieView.legend.form = .none
        pieView.chartDescription = nil
        
        pieView.highlightPerTapEnabled = false
    }
}

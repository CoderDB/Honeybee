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
    
    lazy var pieView: PieChartView = {
        let pie = PieChartView()
        
        pie.drawHoleEnabled = true                      //中环，圆心环是否显示
        pie.holeColor = .white                          //圆心环颜色
        pie.holeRadiusPercent = 0.4                     //圆心环半径 默认50%
        pie.transparentCircleRadiusPercent = 0.5        //中环半径
        
        pie.drawEntryLabelsEnabled = true
        
        
        pie.rotationEnabled = false //旋转开关
        pie.animate(xAxisDuration: 1, yAxisDuration: 1, easingX: nil, easingY: nil)
        
        pie.legend.enabled = false
//        pie.legend.drawInside = true
//        pie.legend.verticalAlignment = .top         // legend显示在上方
//        pie.legend.horizontalAlignment = .right
//        pie.legend.direction = .leftToRight         // legend与描述文字排列方式
//        pie.legend.form = .circle
        
        
        pie.chartDescription = nil
        
        pie.highlightPerTapEnabled = false
        return pie
    }()
    var pieViewData: [Double] = [0]
    var pieViewColor: [UIColor] = [HB.Color.main]
    
    
    // ------------------------------
    // MARK: init
    // ------------------------------
    convenience init(height: CGFloat, names: [String], colors: [UIColor], numbers: [Double]) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        pieView.data = createData(names: names, numbers: numbers, colors: colors)
    }
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ivalueFormatterDelegate = self
        
        let gradientLayer = CAGradientLayer.gradient(colors: [UIColor(rgb: [248, 185, 81]), UIColor(rgb: [252, 91, 107])])
        gradientLayer.frame = CGRect(x: 10, y: 0, width: HB.Screen.w-20, height: frame.height)
        gradientLayer.cornerRadius = HB.Constant.cornerRadius
        layer.addSublayer(gradientLayer)

        addPieView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // ------------------------------
    // MARK: IValueFormatter delegate
    // ------------------------------
    weak var ivalueFormatterDelegate: IValueFormatter?
    
    
    
    // ------------------------------
    // MARK: create PieChartData
    // ------------------------------
    func createData(names: [String], numbers: [Double], colors: [UIColor]) -> PieChartData {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<names.count {
            
            let dataEntry = PieChartDataEntry(value: numbers[i], label: names[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = PieChartDataSet(values: dataEntries, label: nil)
        dataSet.colors = colors
//        dataSet.xValuePosition = .outsideSlice              //坐标值显示位置 默认inside
//        dataSet.yValuePosition = .insideSlice
        dataSet.sliceSpace = 5.0
        
        
//        dataSet.valueLineVariableLength = true              //线长度是否可变
//        dataSet.valueLinePart2Length = 0.8                    //线拐角之后的线长
//        dataSet.valueLinePart1OffsetPercentage = 0.7        //线拐角之前距离圆心长度百分比
//        dataSet.valueLineColor = .black              //线颜色
//        dataSet.valueLineWidth = 1.5                        //线宽
        dataSet.valueTextColor = .white              //线末端字体颜色
        dataSet.valueFont = HB.Font.h5_number           // 线末端字体
        dataSet.valueFormatter = ivalueFormatterDelegate
        
        dataSet.entryLabelFont = HB.Font.h4         // title字体
        
        
        let data = PieChartData(dataSet: dataSet)
        return data
    }
    
    
    // ------------------------------
    // MARK: create PieView
    // ------------------------------
    func addPieView() {
        addSubview(pieView)
        pieView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
//        pieView.data = createData(names: [""], numbers: pieViewData, colors: pieViewColor)
    }
}


extension PieHeader: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return "\(value)%"
    }
}

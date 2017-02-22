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
        
        pie.drawHoleEnabled = true                  //中环，圆心环是否显示
        pie.holeColor = UIColor.white               //圆心环颜色
        pie.holeRadiusPercent = 0.4                 //圆心环半径 默认50%
        pie.transparentCircleRadiusPercent = 0      //中环半径
        
        pie.rotationEnabled = false //旋转开关
        pie.animate(xAxisDuration: 1, yAxisDuration: 1, easingX: nil, easingY: nil)
        
        pie.legend.enabled = false
        
        pie.chartDescription = nil
        
        pie.highlightPerTapEnabled = false
        return pie
    }()
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradientLayer = CAGradientLayer.gradient(colors: [UIColor.rgb(r: 248, g: 185, b: 81), UIColor.rgb(r: 252, g: 91, b: 107)])
        gradientLayer.frame = CGRect(x: 10, y: 0, width: ScreenW-20, height: frame.height)
        gradientLayer.cornerRadius = 10
        layer.addSublayer(gradientLayer)
        
//        backgroundColor = UIColor.white
//        layer.cornerRadius = 10
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
        
        
        addPieView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    override var frame: CGRect {
//        didSet {
//            var newFrame = frame
//            newFrame.origin.x += 10
//            newFrame.size.width -= 20
//            super.frame = newFrame
//        }
//    }
    
    func createData(numbers: [Double]) -> PieChartData {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<numbers.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: numbers[i])
            dataEntries.append(dataEntry)
        }
        let dataSet = PieChartDataSet(values: dataEntries, label: nil)
        dataSet.colors = [UIColor.gray,UIColor.cyan, UIColor.green, UIColor.darkGray, UIColor.red]
        dataSet.xValuePosition = .outsideSlice              //坐标值显示位置
        dataSet.yValuePosition = .outsideSlice
//        dataSet.sliceSpace = 1.0
        
        
        dataSet.valueLineVariableLength = true              //线长度是否可变
        dataSet.valueLinePart2Length = 1                    //线拐角之后的线长
        dataSet.valueLinePart1OffsetPercentage = 0.7        //线拐角之前距离圆心长度百分比
        dataSet.valueLineColor = UIColor.black              //线颜色
        dataSet.valueLineWidth = 1.5                        //线宽
        dataSet.valueTextColor = UIColor.black              //线末端字体颜色
        dataSet.valueFont = HonybeeFont.h4_number           // 线末端字体
        
        return PieChartData(dataSet: dataSet)
    }
    func addPieView() {
        addSubview(pieView)
        pieView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        pieView.data = createData(numbers: [10, 20.58, 30, 8.90, 15.52, 10])
    }
}

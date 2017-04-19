//
//  BarHeader.swift
//  Honeybee
//
//  Created by Dongbing Hou on 22/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit
import Charts

class BarHeader: UIView {

    
    private weak var axisFormatDelegate: IAxisValueFormatter?
    
    // ------------------------------
    // MARK: init
    // ------------------------------
    convenience init(height: CGFloat, data: [Int: Double]) {
        self.init(height: height)
        barView.data = BarHeaderData(data).data
    }
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        axisFormatDelegate = self
        
//        let gradientLayer = CAGradientLayer.gradient(colors: [UIColor(rgb: [248, 185, 81]), UIColor(rgb: [252, 91, 107])])
//        gradientLayer.frame = CGRect(x: 10, y: 0, width: HB.Screen.w-20, height: frame.height)
//        gradientLayer.cornerRadius = HB.Constant.cornerRadius
//        layer.addSublayer(gradientLayer)
//        layer.cornerRadius = HB.Constant.cornerRadius
//        layer.borderWidth = 1
//        backgroundColor = .cyan
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
//            newFrame.origin.y += 20
            newFrame.size = CGSize(width: frame.width-20, height: frame.height)
            super.frame = newFrame
        }
    }
    
    // ------------------------------
    // MARK: bar view
    // ------------------------------
    
    lazy var barView: BarChartView = {
        let barV = BarChartView()
        
        barV.noDataText = "暂无数据"
        barV.chartDescription = nil
        
//        barV.leftAxis.drawZeroLineEnabled = false
//        
//        
//        // xAxis
        barV.xAxis.drawAxisLineEnabled = true      //不显示x轴
        barV.xAxis.axisLineColor = .black
//        barV.xAxis.axisLineDashPhase = 5
//        barV.xAxis.yOffset = -50
        
        barV.xAxis.drawGridLinesEnabled = false     // 不显示竖格线
        barV.xAxis.labelPosition = .bottom
        barV.xAxis.labelTextColor = .black
//        barV.xAxis.drawLabelsEnabled = true        // x轴坐标值是否绘制 default true
        
        
//        barV.leftAxis.axisMinimum = 0
        
//        barV.xAxis.labelCount = 30
//        barV.xAxis.axisMinimum = 0
//        barV.xAxis.axisMaximum = 30
//        barV.xAxis.axisRange = 10
//        barV.xAxis.spaceMin = 1
//        barV.xAxis.spaceMax = 30
//        barV.xAxis.axisLineColor = .black
//        barV.xAxis.labelTextColor = .black

        
//        barV.fitBars = true
        
        
        // x, y轴双击都不缩放
        barV.scaleXEnabled = false
        barV.scaleYEnabled = false
        
        
        
        barV.rightAxis.enabled = false
        
        barV.leftAxis.enabled = false
        barV.leftAxis.drawGridLinesEnabled = false // leftAxis 横线
        barV.leftAxis.drawLabelsEnabled = false  // leftAxis 坐标值
        barV.leftAxis.drawZeroLineEnabled = false
        
        barV.drawValueAboveBarEnabled = true // 条形柱的值显示在条形柱上发
        

        barV.legend.enabled = false
        
        barV.isUserInteractionEnabled = false
        
        
        
        barV.layer.cornerRadius = HB.Constant.cornerRadius
        barV.layer.masksToBounds = true
        
        barV.backgroundColor = UIColor.cyan
        
        return barV
    }()
    
    func setupUI() {
        addSubview(barView)
        barView.snp.makeConstraints { (make) in
            make.left.equalTo(self)//.offset(20)
            make.right.equalTo(self)//.offset(-20).priority(HB.Priority.mid)
//            make.bottom.equalTo(self).offset(-5)
            make.top.equalTo(self)
            
            make.height.equalTo(self.snp.width).multipliedBy(UIScreen.main.bounds.width/UIScreen.main.bounds.height)
        }
        
        barView.xAxis.valueFormatter = axisFormatDelegate
    }
}



// ------------------------------
// MARK: IAxisValueFormatter
// ------------------------------

extension BarHeader: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))日"
    }
}


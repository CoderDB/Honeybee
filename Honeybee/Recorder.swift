//
//  Reocder.swift
//  Honeybee
//
//  Created by Dongbing Hou on 10/02/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//


import UIKit

enum MoneyType {
    case `in`, out
}

class Recorder: NSObject {
    var id: String
    
    var date: String
    var category: [String]
    var money: String
    var remark: String?
    var color: UIColor
    var type: MoneyType
    //    var parent:
    
    init(type: MoneyType = .out, date: String, category: [String], money: String, remark: String? = nil, color: UIColor) {
        self.id = date
        self.date = date
        self.category = category
        self.money = money
        self.remark = remark
        self.color = color
        self.type = type
        super.init()
        let date = self.nowDate(anyDate: Date())
        self.yearMonthDay(date: date)
    }
    
    /// 2017-02-26 10:48:11 +0000 -> 2017-02-26 18:48:11 +0000
    func nowDate(anyDate: Date) -> Date {
        let sourceTZ = TimeZone(identifier: "GMT")!
        let destinationTZ = TimeZone.current
        let sourceGMTOffset = sourceTZ.secondsFromGMT(for: anyDate)
        let destinationGMTOffset = destinationTZ.secondsFromGMT(for: anyDate)
        let interval = TimeInterval(destinationGMTOffset - sourceGMTOffset)
        print(Date(timeInterval: interval, since: anyDate))
        return Date(timeInterval: interval, since: anyDate)
    }
    
    /// 2017-02-26 18:35:52 +0000 -> 2017, 2, 26
    func yearMonthDay(date: Date) -> (year: String, month: String, day: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "GMT")
        let dateStr = formatter.string(from: date)
        print("------\(dateStr)")
        let components = dateStr.components(separatedBy: "-")
        print("****\((components[0], components[1], components[2]))")
        return (components[0], components[1], components[2])
    }
    
    /// 2017-02-26 18:35:52 +0000 -> 2017, 2, 26
    func getYearMonthDay(date: Date) -> String {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "GMT")!
        let day = cal.component(.day, from: date)
        let month = cal.component(.month, from: date)
        let year = cal.component(.year, from: date)
//        let ymd = cal.dateComponents([.year, .month, .day], from: date)
        let monthDay = "\(year)-\(month)-\(day)"
        return monthDay
    }
}



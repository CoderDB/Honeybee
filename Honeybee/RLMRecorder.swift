//
//  RLMRecorder.swift
//  Honeybee
//
//  Created by Dongbing Hou on 03/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import RealmSwift
import ObjectMapper

class RLMRecorder: RLMModel {
    
    
    
    dynamic var date: String = "\(Date())"
//        {
//        didSet {
//            let currentDate = Date.date(from: date).localDate
//            self.year = currentDate.year
//            self.month = currentDate.month
//            self.day = currentDate.day
//        }
//    }
    

    
    
    dynamic var superCategory: String = ""
    dynamic var category: String = ""
    dynamic var money: Double = 0
    dynamic var remark: String = "未填写\n"
    dynamic var color: String = ""
    dynamic var isPay: Bool = true
    dynamic var imageName: String = "meal"
    
    
    dynamic var owner: RLMRecorderSuper?
    
    var month_day: String {
        return Date.date(from: date).localDate.month_day
    }
    var monthDay: String {
        return Date.date(from: date).localDate.monthDay
    }
    var weekday: String {
        return Date.date(from: date).localDate.weekday
    }
    var yearMonthDay: String {
        return Date.date(from: date).localDate.yearMonthDay
    }
    var hourMinute:String {
        return Date.date(from: date).localDate.hourMinute
    }
    
    
    
    
    var year: Int {
        return Date.date(from: date).localDate.year
    }
    var month: Int {
        return Date.date(from: date).localDate.month
    }
    var day: Int {
        return Date.date(from: date).localDate.day
    }
    
//    var year: String {
//        return Date.date(from: date).localDate.year
//    }
//    var month: String {
//        return Date.date(from: date).localDate.month
//    }
    
    
    override static func ignoredProperties() -> [String] {
        return ["weekday", "yearMonthDay", "hourMinute", "monthDay"]
    }
    
    override static func indexedProperties() -> [String] {
        return ["superCategory"]
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
//        self.id <- map[id]
        self.date <- map["date"]
        self.category <- map["category"]
        self.superCategory <- map["superCategory"]
        self.money <- map["money"]
        self.remark <- map["remark"]
        self.color <- map["color"]
        self.isPay <- map["isPay"]
        self.imageName <- map["imageName"]
        
        
//        let currentDate = Date.date(from: date).localDate
//        self.monthDay = currentDate.monthDay
//        self.weekday = currentDate.weekday
//        self.yearMonthDay = currentDate.yearMonthDay
//        self.hourMinute = currentDate.hourMinute
    }
}


//func == (lhs: RLMRecorder, rhs: RLMRecorder) -> Bool {
//    return lhs.yearMonthDay == rhs.yearMonthDay
//}
//func group<T: Equatable>(recorders: [T]) -> [[T]] where T: RLMRecorder {
//    guard let head = recorders.first else { return [] }
//    let tail = Array(recorders.dropFirst())
//    var take = takeWhile(condition: { $0 == head }, source: tail)
//    take.insert(head, at: 0)
//    
//    let drop = dropWhile(condition: { $0 == head }, source: tail)
//    var temp = group(source: drop)
//    temp.insert(take, at: 0)
//    return temp
//}

// ----------------------------------------------------------------------
// TODO: Sequence
// ----------------------------------------------------------------------

func group<T: Equatable>(source: [T]) -> [[T]] {
    guard let head = source.first else { return [] }
    let tail = Array(source.dropFirst())
    var take = takeWhile(condition: { $0 == head }, source: tail)
    take.insert(head, at: 0)
    
    let drop = dropWhile(condition: { $0 == head }, source: tail)
    var temp = group(source: drop)
    temp.insert(take, at: 0)
    return temp
}

func group<T: Equatable>(source: [T], condition: (T) -> (T) -> Bool)  -> [[T]] {
    guard let head = source.first else { return [] }
    let tail = Array(source.dropFirst())
    var take = takeWhile(condition: condition(head), source: tail)
    take.insert(head, at: 0)
    
    let drop = dropWhile(condition: condition(head), source: tail)
    var temp = group(source: drop)
    temp.insert(take, at: 0)
    return temp
}


//func groupWith<T: Equatable>(condition: (T) -> (T) -> Bool, source: [T]) -> [[T]] {
//    guard let head = source.first else { return [] }
//    
//    let tail = Array(source.dropFirst())
//    var take = takeWhile(condition: { $0 == head }, source: tail)
//    take.insert(head, at: 0)
//    
//    let drop = dropWhile(condition: { $0 == head }, source: tail)
//    var temp = group(source: drop)
//    temp.insert(take, at: 0)
//    return temp
//}


func takeWhile<T: Any>(condition: (T) -> Bool, source: [T]) -> [T] {
    var result = [T]()
    for element in source {
        if condition(element) {
            result.append(element)
        } else {
            break
        }
    }
    return result
}

func dropWhile<T: Any>(condition: (T) -> Bool, source: [T]) -> [T] {
    var matched = [T]()
    for element in source {
        if condition(element) {
            matched.append(element)
        } else {
            break
        }
    }
    return Array(source.dropFirst(matched.count))
}




















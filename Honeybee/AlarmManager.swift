//
//  AlarmManager.swift
//  Honeybee
//
//  Created by Dongbing Hou on 02/04/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import UIKit

class Alarm {
    
    static let `default` = Alarm()
    private init() {}
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        let settings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
        
        if UIApplication.shared.currentUserNotificationSettings?.types != .none {
            let noti = UILocalNotification()
            noti.timeZone = .current
            noti.fireDate = Date(timeIntervalSinceNow: 10)
            noti.alertBody = "hahhahahah"
            noti.repeatInterval = .minute
            noti.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(noti)
        }
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) {
        
    }
}

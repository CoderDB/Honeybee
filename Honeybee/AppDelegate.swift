//
//  AppDelegate.swift
//  Honeybee
//
//  Created by Dongbing Hou on 23/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let barAppearence = UINavigationBar.appearance()
        barAppearence.isTranslucent = true
        barAppearence.setBackgroundImage(UIImage.image(color: .white), for: .any, barMetrics: .default)
        barAppearence.shadowImage = UIImage()
        // 设置导航栏返回按钮，文字颜色
        barAppearence.tintColor = HB.Color.nav
        
        let buttonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        buttonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical: -100), for: .default)
        
        let nav = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    
        return true
    }
}

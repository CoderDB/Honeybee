//
//  AppDelegate.swift
//  Honeybee
//
//  Created by Dongbing Hou on 23/11/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var isLogin: Bool = false
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Alarm.default.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        setupNavAppearance()
        
        if isLogin {
            let viewModel = MainViewModel(provider: RxMoyaProvider<ApiProvider>())
            let vc = MainViewController(viewModel: viewModel)
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        } else {
            let nav = UINavigationController(rootViewController: LoginViewController())
            window?.rootViewController = nav
        }
        
        window?.makeKeyAndVisible()
       
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        Alarm.default.application(application, didReceive: notification)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        Alarm.default.application(app, open: url, options: options)
        return true
    }
    
}

extension AppDelegate {
    func setupNavAppearance() {
        let barAppearence = UINavigationBar.appearance()
        barAppearence.isTranslucent = true
        barAppearence.setBackgroundImage(UIImage.image(color: .white), for: .any, barMetrics: .default)
        barAppearence.shadowImage = UIImage()
        // 设置导航栏返回按钮，文字颜色
        barAppearence.tintColor = HB.Color.nav
        
        let buttonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        buttonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical: -100), for: .default)
    }
}

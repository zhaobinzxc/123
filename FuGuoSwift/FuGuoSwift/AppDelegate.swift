//
//  AppDelegate.swift
//  FuGuoSwift
//
//  Created by 赵彬 on 2020/5/29.
//  Copyright © 2020 赵彬. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        self.window =  UIWindow.init(frame: UIScreen.main.bounds)
        let main:FGMainViewController = FGMainViewController.init()
        
        let nav:FGNavigationController = FGNavigationController.init(rootViewController: main)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

   


}


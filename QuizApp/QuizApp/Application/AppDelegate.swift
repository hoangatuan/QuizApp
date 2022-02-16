//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 15/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        let questionVC = QuestionViewController(question: "Q1", options: ["A1", "A2", "A3"], callback: {
            debugPrint($0)
        })
        _ = questionVC.view
//        questionVC.optionsTableView.allowsMultipleSelection = true
        window.rootViewController = questionVC
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

}


//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import UIKit
import QuizEnginee

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController!
    private let viewControllerFactory:  ViewControllerFactory!
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = factory
    }
    
    func routeTo(question: String, callback: @escaping (String) -> Void) {
        let viewController = viewControllerFactory.questionViewController(for: question, answer: callback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(results: QuizResult<String, String>) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
}

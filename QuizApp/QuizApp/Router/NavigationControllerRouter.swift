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
    
    func routeTo(question: Question<String>, callback: @escaping ([String]) -> Void) {
        let viewController = viewControllerFactory.questionViewController(for: question, answer: callback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(results: QuizResult<Question<String>, [String]>) {
        let resultViewController = viewControllerFactory.resultViewController(for: results)
        navigationController.pushViewController(resultViewController, animated: true)
    }
}

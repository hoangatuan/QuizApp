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
        switch question {
        case .singleAnswer:
            let viewController = viewControllerFactory.questionViewController(for: question, answer: callback)
            navigationController.pushViewController(viewController, animated: true)
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .done, target: self, action: nil)
            let controller = SubmitButtonController(button: button, callback: callback)
            let viewController = viewControllerFactory.questionViewController(for: question, answer: { answers in
                controller.updateListAnswers(answers)
            })
            
            viewController.navigationItem.rightBarButtonItem = button
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func routeTo(results: QuizResult<Question<String>, [String]>) {
        let resultViewController = viewControllerFactory.resultViewController(for: results)
        navigationController.pushViewController(resultViewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    private var button: UIBarButtonItem
    private var callback: ([String]) -> Void
    private var answers: [String] = []
    
    init(button: UIBarButtonItem, callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        button.isEnabled = false
        button.target = self
        button.action = #selector(handleTap)
    }
    
    func updateListAnswers(_ answers: [String]) {
        self.answers = answers
        button.isEnabled = !answers.isEmpty
    }
    
    @objc
    private func handleTap() {
        callback(answers)
    }
}

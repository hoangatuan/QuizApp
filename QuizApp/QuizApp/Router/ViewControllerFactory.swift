//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import UIKit
import QuizEnginee

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answer: @escaping ([String]) -> Void) -> UIViewController
    func resultViewController(for result: QuizResult<Question<String>, [String]>) -> UIViewController
}

class IOSViewControllerFactory: ViewControllerFactory {
    private let options: [Question<String>: [String]]
     
    init(options: [Question<String>: [String]]) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answer: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = options[question] else {
            fatalError("Can not find options for this question!")
        }
        
        return createQuestionViewController(question: question, options: options, callback: answer)
    }
    
    func resultViewController(for result: QuizResult<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}

extension IOSViewControllerFactory {
    private func createQuestionViewController(question: Question<String>, options: [String], callback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return QuestionViewController(question: value, options: options, callback: callback)
        case .multipleAnswer(let value):
            let controller = QuestionViewController(question: value, options: options, callback: callback)
            controller.loadViewIfNeeded()
            controller.optionsTableView.allowsMultipleSelection = true
            return controller
        }
    }
}

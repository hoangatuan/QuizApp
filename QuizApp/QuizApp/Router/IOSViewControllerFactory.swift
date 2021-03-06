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
    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]
    private let correctAnswers: [Question<String>: [String]]
     
    init(questions: [Question<String>], options: [Question<String>: [String]], correctAnswers: [Question<String>: [String]]) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for question: Question<String>, answer: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = options[question] else {
            fatalError("Can not find options for this question!")
        }
        
        return createQuestionViewController(question: question, options: options, callback: answer)
    }
    
    func resultViewController(for result: QuizResult<Question<String>, [String]>) -> UIViewController {
        let presenter = ResultPresenter(questions: questions,
                                        result: result,
                                        correctAnswers: correctAnswers)
        return ResultViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
    }
}

extension IOSViewControllerFactory {
    private func createQuestionViewController(question: Question<String>, options: [String], callback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return questionViewController(question: question, value: value, options: options, allowsMultipleSelection: false, callback: callback)
        case .multipleAnswer(let value):
            return questionViewController(question: question, value: value, options: options, allowsMultipleSelection: true, callback: callback)
        }
    }
    
    private func questionViewController(question: Question<String>, value: String, options: [String],
                                        allowsMultipleSelection: Bool,
                                        callback: @escaping ([String]) -> Void) -> QuestionViewController {
        let controller = QuestionViewController(question: value, options: options, allowsMultipleSelection: allowsMultipleSelection, callback: callback)
        let presenter = QuestionPresenter(questions: questions, question: question)
        controller.title = presenter.title
        return controller
    }
}

//
//  IOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import Foundation
import QuizEnginee
@testable import QuizApp
import XCTest

class IOSViewControllerFactoryTest: XCTestCase {
    private let options = ["A1", "A2"]
    private let singleAnswerQuestion = Question.singleAnswer("Q1")
    private let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    
    func test_questionViewController_singleAnswer_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        let factory = makeSUT(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: [singleAnswerQuestion: options, multipleAnswerQuestion: options])
        
        let viewController = factory.questionViewController(for: singleAnswerQuestion, answer: { _ in })
        XCTAssertEqual(viewController.title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        let factory = makeSUT(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: [singleAnswerQuestion: options, multipleAnswerQuestion: options])
        
        let viewController = factory.questionViewController(for: multipleAnswerQuestion, answer: { _ in })
        XCTAssertEqual(viewController.title, presenter.title)
    }
    
    func test_singleAnswer_createQuestionViewController() {
        let viewController = makeQuestionViewController()
        XCTAssertNotNil(viewController)
    }
    
    func test_singleAnswer_createQuestionViewController_WithCorrectOptions() {
        let viewController = makeQuestionViewController()
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_singleAnswer_createQuestionViewController_WithCorrectQuestion() {
        let viewController = makeQuestionViewController()
        XCTAssertEqual(viewController.question, "Q1")
    }
    
    func test_singleAnswer_createQuestionViewController_singleSelection() {
        let viewController = makeQuestionViewController()
        XCTAssertFalse(viewController.optionsTableView.allowsMultipleSelection)
    }
    
    func test_multipleAnswers_createQuestionViewController() {
        let viewController = makeQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertNotNil(viewController)
    }
    
    func test_multipleAnswers_createQuestionViewController_WithCorrectOptions() {
        let viewController = makeQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_multipleAnswers_createQuestionViewController_WithCorrectQuestion() {
        let viewController = makeQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertEqual(viewController.question, "Q1")
    }
    
    func test_multipleAnswers_createQuestionViewController_multipleSelection() {
        let viewController = makeQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertTrue(viewController.optionsTableView.allowsMultipleSelection)
    }
    
    func test_routeToResult_routeCorrectly() {
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let userAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1, A2"]]
        
        let result = QuizResult(answers: userAnswers, score: 1)
        let presenter = ResultPresenter(questions: questions, result: result, correctAnswers: correctAnswers)
        
        let factory = makeSUT(questions: questions, correctAnswers: correctAnswers)
        let viewController = factory.resultViewController(for: result) as! ResultViewController
        
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController.summary, presenter.summary)
        XCTAssertEqual(viewController.answers.count, presenter.presentableAnswers.count)
    }
    
    // MARK: - Helpers
    func makeSUT(questions: [Question<String>] = [],
                 options: [Question<String>: [String]] = [:],
                 correctAnswers: [Question<String>: [String]] = [:]) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(questions: questions, options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        let factory = IOSViewControllerFactory(questions: [], options: [question:options], correctAnswers: [:])
        let controller = factory.questionViewController(for: question, answer: { _ in }) as! QuestionViewController
        controller.loadViewIfNeeded()
        return controller
    }
}

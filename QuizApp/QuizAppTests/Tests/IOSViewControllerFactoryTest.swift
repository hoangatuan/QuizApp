//
//  IOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import Foundation
@testable import QuizApp
import XCTest

class IOSViewControllerFactoryTest: XCTestCase {
    private let options = ["A1", "A2"]
    
    private let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    
    func test_questionViewController_singleAnswer_createControllerWithTitle() {
        let singleAnswerQuestion = Question.singleAnswer("Q1")
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        let factory = IOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: [singleAnswerQuestion: options, multipleAnswerQuestion: options])
        
        let viewController = factory.questionViewController(for: singleAnswerQuestion, answer: { _ in })
        XCTAssertEqual(viewController.title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createControllerWithTitle() {
        let singleAnswerQuestion = Question.singleAnswer("Q1")
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        let factory = IOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: [singleAnswerQuestion: options, multipleAnswerQuestion: options])
        
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
    
    // MARK: - Helpers
    func makeSUT(question: Question<String>) -> IOSViewControllerFactory{
        return IOSViewControllerFactory(questions: [], options: [question:options])
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        let controller = makeSUT(question: question).questionViewController(for: question, answer: { _ in }) as! QuestionViewController
        controller.loadViewIfNeeded()
        return controller
    }
}

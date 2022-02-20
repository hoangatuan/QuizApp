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
        let viewController = makeQuestionViewController(question: Question.multipleAnswer("Q1"))
        XCTAssertNotNil(viewController)
    }
    
    func test_multipleAnswers_createQuestionViewController_WithCorrectOptions() {
        let viewController = makeQuestionViewController(question: Question.multipleAnswer("Q1"))
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_multipleAnswers_createQuestionViewController_WithCorrectQuestion() {
        let viewController = makeQuestionViewController(question: Question.multipleAnswer("Q1"))
        XCTAssertEqual(viewController.question, "Q1")
    }
    
    func test_multipleAnswers_createQuestionViewController_multipleSelection() {
        let viewController = makeQuestionViewController(question: Question.multipleAnswer("Q1"))
        XCTAssertTrue(viewController.optionsTableView.allowsMultipleSelection)
    }
    
    // MARK: - Helpers
    func makeSUT(question: Question<String>) -> IOSViewControllerFactory{
        return IOSViewControllerFactory(options: [question:options])
    }
    
    func makeQuestionViewController(question: Question<String> = Question.singleAnswer("Q1")) -> QuestionViewController {
        let controller = makeSUT(question: question).questionViewController(for: question, answer: { _ in }) as! QuestionViewController
        controller.loadViewIfNeeded()
        return controller
    }
}

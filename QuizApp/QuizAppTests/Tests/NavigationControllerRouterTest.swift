//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import UIKit
import XCTest
import QuizEnginee
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    private let navigationController = MockNavigationController()
    private let factory = ViewControllerFactoryStub()
    private var router: NavigationControllerRouter!
    
    private let questionSingleAnswer = Question.singleAnswer("Q1")
    private let questionMultipleAnswers = Question.multipleAnswer("Q1")
    
    override func setUp() {
        super.setUp()
        router = NavigationControllerRouter(navigationController, factory: factory)
    }
    
    func test_routeToSecondQuestion_presentsTwoQuestionController() {
        let viewController = UIViewController()
        let viewController2 = UIViewController()
        factory.stub(question: questionSingleAnswer, with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: viewController2)
        
        router.routeTo(question: questionSingleAnswer, callback: { _ in })
        router.routeTo(question: Question.singleAnswer("Q2"), callback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, viewController2)
    }
    
    func test_routeToQuestion_singleAnswer_selectAnswer_fireCallback() {
        var callbackDidFire = false
        router.routeTo(question: questionSingleAnswer) { _ in
            callbackDidFire = true
        }
        factory.answerCallback[questionSingleAnswer]!([""])
        XCTAssertTrue(callbackDidFire)
    }
    
    func test_routeToQuestion_multipleAnswer_selectAnswer_doesNotFireCallback() {
        var callbackDidFire = false
        router.routeTo(question: questionMultipleAnswers) { _ in
            callbackDidFire = true
        }
        
        factory.answerCallback[questionMultipleAnswers]!([""])
        XCTAssertFalse(callbackDidFire)
    }
    
    func test_routeToQuestion_singleAnswer_doesNotConfigureSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: questionSingleAnswer, with: viewController)
        router.routeTo(question: questionSingleAnswer, callback: { _ in })
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        factory.stub(question: questionMultipleAnswers, with: viewController)
        router.routeTo(question: questionMultipleAnswers, callback: { _ in })
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_routeToQuestion_multipleAnswer_disableSubmitButtonWhenNoAnswerSelected() {
        let viewController = UIViewController()
        factory.stub(question: questionMultipleAnswers, with: viewController)
        router.routeTo(question: questionMultipleAnswers, callback: { _ in })
        
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        factory.answerCallback[questionMultipleAnswers]!([""])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        factory.answerCallback[questionMultipleAnswers]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswer_enableSubmitButtonWhenAtLeast1AnswerSelected() {
        let viewController = UIViewController()
        factory.stub(question: questionMultipleAnswers, with: viewController)
        router.routeTo(question: questionMultipleAnswers, callback: { _ in })
        factory.answerCallback[questionMultipleAnswers]!([""])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_routeToQuestion_multipleAnswer_tapSubmitButton_fireCallback() {
        var callbackDidFire = false
        let viewController = UIViewController()
        factory.stub(question: questionMultipleAnswers, with: viewController)
        router.routeTo(question: questionMultipleAnswers, callback: { _ in
            callbackDidFire = true
        })
        
        factory.answerCallback[questionMultipleAnswers]!([""])
        viewController.navigationItem.rightBarButtonItem?.tapSimulate()

        XCTAssertTrue(callbackDidFire)
    }
    
    func test_routeToResult_showResultViewController() {
        let viewController = UIViewController()
        factory.stubResult(with: viewController)
        
        var result: QuizResult<Question<String>, [String]>
        result = QuizResult(answers: [:], score: 0)
        router.routeTo(results: result)
        XCTAssertEqual(navigationController.viewControllers.last, viewController)
    }
}

private class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions: [Question<String>: UIViewController] = [:]
    private var resultViewController: UIViewController?
    var answerCallback: [Question<String>: ([String]) -> Void] = [:]
    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func stubResult(with viewController: UIViewController) {
        resultViewController = viewController
    }
    
    func questionViewController(for question: Question<String>, answer: @escaping ([String]) -> Void) -> UIViewController {
        answerCallback[question] = answer
        return stubbedQuestions[question] ?? UIViewController()
    }
    
    func resultViewController(for result: QuizResult<Question<String>, [String]>) -> UIViewController {
        return resultViewController ?? UIViewController()
    }
}

private class MockNavigationController: UINavigationController {
    // Because if animated = true => After finish animation, viewController push to navigation stack.
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

private extension UIBarButtonItem {
    func tapSimulate() {
        target?.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}

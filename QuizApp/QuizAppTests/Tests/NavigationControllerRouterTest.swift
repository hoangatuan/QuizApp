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
    
    override func setUp() {
        super.setUp()
        router = NavigationControllerRouter(navigationController, factory: factory)
    }
    
    func test_routeToQuestion_presentsOneQuestionController() {
        let viewController = UIViewController()
        
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        router.routeTo(question: Question.singleAnswer("Q1"), callback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    func test_routeToSecondQuestion_presentsTwoQuestionController() {
        let viewController = UIViewController()
        let viewController2 = UIViewController()
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: viewController2)
        
        router.routeTo(question: Question.singleAnswer("Q1"), callback: { _ in })
        router.routeTo(question: Question.singleAnswer("Q2"), callback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, viewController2)
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
    
    func stub(question: Question<String>, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func stubResult(with viewController: UIViewController) {
        resultViewController = viewController
    }
    
    func questionViewController(for question: Question<String>, answer: ([String]) -> Void) -> UIViewController {
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

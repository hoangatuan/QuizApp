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
        
        factory.stub(question: "Q1", with: viewController)
        router.routeTo(question: "Q1", callback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }
    
    func test_routeToSecondQuestion_presentsTwoQuestionController() {
        let viewController = UIViewController()
        let viewController2 = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: viewController2)
        
        router.routeTo(question: "Q1", callback: { _ in })
        router.routeTo(question: "Q2", callback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, viewController2)
    }
}

private class ViewControllerFactoryStub: ViewControllerFactory {
    private var stubbedQuestions: [String: UIViewController] = [:]
    
    func stub(question: String, with viewController: UIViewController) {
        stubbedQuestions[question] = viewController
    }
    
    func questionViewController(for question: String, answer: (String) -> Void) -> UIViewController {
        return stubbedQuestions[question] ?? UIViewController()
    }
}

private class MockNavigationController: UINavigationController {
    // Because if animated = true => After finish animation, viewController push to navigation stack.
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: false)
    }
}

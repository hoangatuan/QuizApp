//
//  FlowTest.swift
//  QuizEngineeTests
//
//  Created by Hoang Anh Tuan on 12/02/2022.
//

import Foundation
import XCTest
@testable import QuizEnginee

class FlowTest: XCTestCase {
    let router = RouterMock()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_routesToFirstQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_routeToQuestion2_WhenAnswerQuestion1() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.callbackAnswer("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_routeToQuestion3_WhenAnswerQuestion12() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.callbackAnswer("A1")
        router.callbackAnswer("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    class RouterMock: Router {
        var routedQuestions: [String] = []
        var callbackAnswer: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, callback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            callbackAnswer = callback
        }
    }
}

extension FlowTest {
    func makeSUT(questions: [String]) -> Flow {
        let sut = Flow(questions: questions, router: router)
        return sut
    }
}

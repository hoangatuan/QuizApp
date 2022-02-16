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
    
    func test_startWith1Question_answer1Question_doesNotRoute() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.callbackAnswer("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_answerAllQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.callbackAnswer("A1")
        router.callbackAnswer("A2")
        
        XCTAssertEqual(router.results, ["Q1":"A1", "Q2":"A2"])
    }
    
    func test_notAnswerAllQuestion_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.callbackAnswer("A1")
        XCTAssertNil(router.results)
    }
    
    func test_WithNoQuestion_RouteToResult() {
        let sut = makeSUT(questions: [])
        sut.start()
        
        XCTAssertEqual(router.results, [:])
    }
    
    class RouterMock: Router {
        var results: [String: String]?
        var routedQuestions: [String] = []
        var callbackAnswer: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, callback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            callbackAnswer = callback
        }
        
        func routeTo(results: [String : String]) {
            self.results = results
        }
    }
}

extension FlowTest {
    func makeSUT(questions: [String]) -> Flow<String, String, RouterMock> {
        let sut = Flow(questions: questions, router: router)
        return sut
    }
}

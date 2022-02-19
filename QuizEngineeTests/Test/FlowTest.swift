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
        
        XCTAssertEqual(router.results?.answers, ["Q1":"A1", "Q2":"A2"])
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
        
        XCTAssertEqual(router.results?.answers, [:])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_score() {
        let sut = makeSUT(questions: ["Q1", "Q2"]) { _ in
            return 10
        }
        sut.start()
        
        router.callbackAnswer("A1")
        router.callbackAnswer("A2")
        
        XCTAssertEqual(router.results?.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoreWithCorrectAnswers() {
        var receivedAnswers: [String: String]?
        let sut = makeSUT(questions: ["Q1", "Q2"]) {
            receivedAnswers = $0
            return 10
        }
        sut.start()
        
        router.callbackAnswer("A1")
        router.callbackAnswer("A2")
        XCTAssertEqual(receivedAnswers, ["Q1":"A1", "Q2":"A2"])
    }
}

extension FlowTest {
    func makeSUT(questions: [String],
                 scoring: @escaping ([String: String]) -> Int = { _ in return 0 }) -> Flow<String, String, RouterMock> {
        let sut = Flow(questions: questions, router: router, scoring: scoring)
        return sut
    }
}

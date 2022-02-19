//
//  GameTest.swift
//  QuizEngineeTests
//
//  Created by Hoang Anh Tuan on 17/02/2022.
//

import Foundation
import XCTest
import QuizEnginee

class GameTest: XCTestCase {
    var router: RouterMock!
    var game: Game<String, String, RouterMock>!
    
    override func setUp() {
        super.setUp()
        router = RouterMock()
        game = startGame(question: ["Q1", "Q2"], router: router, correctAnswer: ["Q1": "A1", "Q2":"A2"])
    }
    
    func test_startGame_answerZeroOutOfTwo_score0() {
        router.callbackAnswer("B1")
        router.callbackAnswer("B2")
        
        XCTAssertEqual(router.results?.score, 0)
    }
    
    func test_startGame_answerOneOutOfTwo_score1() {
        router.callbackAnswer("A1")
        router.callbackAnswer("B2")
        
        XCTAssertEqual(router.results?.score, 1)
    }
    
    func test_startGame_answerTwoOutOfTwo_score2() {
        router.callbackAnswer("A1")
        router.callbackAnswer("A2")
        
        XCTAssertEqual(router.results?.score, 2)
    }
}

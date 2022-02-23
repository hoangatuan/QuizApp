//
//  ResultPresenterTest.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 20/02/2022.
//

import Foundation
import XCTest
import QuizEnginee
@testable import QuizApp

class ResultPresenterTest: XCTestCase {
    private let singleQuestion1 = Question.singleAnswer("Q1")
    private let multipleQuestion1 = Question.multipleAnswer("MQ1")
    
    func test_answerCorrectOneOutOfTwo_generateCorrectSummary() {
        let result = QuizResult<Question<String>, [String]>(answers: [singleQuestion1:["A1"],
                                                                    multipleQuestion1:["A2"]],
                                                            score: 1)
        let sut = ResultPresenter(questions: [singleQuestion1, multipleQuestion1], result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswer_withWrongSingleAnswer_mapsAnswer() {
        let result = QuizResult<Question<String>, [String]>(answers: [singleQuestion1: ["A1"]], score: 0)
        let correctAnswers: [Question<String>: [String]] = [singleQuestion1: ["A2"]]
        
        let sut = ResultPresenter(questions: [singleQuestion1], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1")
    }
    
    func test_presentableAnswer_withRightSingleAnswer_mapsAnswer() {
        let result = QuizResult<Question<String>, [String]>(answers: [singleQuestion1: ["A1"]], score: 0)
        let correctAnswers: [Question<String>: [String]] = [singleQuestion1: ["A1"]]
        
        let sut = ResultPresenter(questions: [singleQuestion1], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }
    
    func test_presentableAnswer_withWrongMultipleAnswers_mapsAnswer() {
        let result = QuizResult<Question<String>, [String]>(answers: [multipleQuestion1: ["A1", "A2"]], score: 0)
        let correctAnswers: [Question<String>: [String]] = [multipleQuestion1: ["A2", "A3"]]
        
        let sut = ResultPresenter(questions: [multipleQuestion1], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.first?.question, "MQ1")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1, A2")
    }
    
    func test_presentableAnswer_withWRightMultipleAnswers_mapsAnswer() {
        let result = QuizResult<Question<String>, [String]>(answers: [multipleQuestion1: ["A1", "A2"]], score: 0)
        let correctAnswers: [Question<String>: [String]] = [multipleQuestion1: ["A1", "A2"]]
        
        let sut = ResultPresenter(questions: [multipleQuestion1], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.first?.question, "MQ1")
        XCTAssertEqual(sut.presentableAnswers.first?.correctAnswer, "A1, A2")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
    }
    
    func test_presentableAnswer_withCorrectOrders() {
        let result = QuizResult<Question<String>, [String]>(answers: [multipleQuestion1: ["A2", "A3"],
                                                                        singleQuestion1: ["A1"]], score: 0)
        
        let correctAnswers: [Question<String>: [String]] = [multipleQuestion1: ["A2", "A3"],
                                                              singleQuestion1: ["A4"]]
        
        let sut = ResultPresenter(questions: [singleQuestion1, multipleQuestion1], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers[0].question, "Q1")
        XCTAssertEqual(sut.presentableAnswers[1].question, "MQ1")
    }
}

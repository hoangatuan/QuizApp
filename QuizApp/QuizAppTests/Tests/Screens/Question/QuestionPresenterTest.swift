//
//  QuestionPresenter.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 20/02/2022.
//

import Foundation
import XCTest
import QuizEnginee
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    
    func test_title_forFirstQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatTitleForIndex() {
        let sut = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [], question: Question.singleAnswer("Q3"))
        XCTAssertEqual(sut.title, "")
    }
}

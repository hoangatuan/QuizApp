//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionTest: XCTestCase {
    func test_questions_isEqual() {
        XCTAssertEqual(Question.singleAnswer("value"), Question.singleAnswer("value"))
        XCTAssertEqual(Question.multipleAnswer("value"), Question.multipleAnswer("value"))
    }
    
    func test_questions_isNotEqual() {
        XCTAssertNotEqual(Question.singleAnswer("value1"), Question.singleAnswer("value2"))
        XCTAssertNotEqual(Question.multipleAnswer("value1"), Question.multipleAnswer("value2"))
        XCTAssertNotEqual(Question.singleAnswer("value"), Question.multipleAnswer("value"))
    }
}

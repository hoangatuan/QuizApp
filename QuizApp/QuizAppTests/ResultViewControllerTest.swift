//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 16/02/2022.
//

import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderSummaryHeaderCorrect() {
        XCTAssertEqual(makeSUT(summary: "A summary").headerLabel.text, "A summary")
    }
    
    func test_viewDidLoad_renderCorrect() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: [makeAnswer()]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(answers: [makeAnswer(), makeAnswer()]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_renderCorrectCellType() {
        let sut = makeSUT(answers: [makeAnswer(), makeAnswer(wrongAnswer: "")])
        let firstCell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        let secondCell = sut.tableView.cell(at: 1) as? WrongAnswerCell
        
        XCTAssertNotNil(firstCell)
        XCTAssertNotNil(secondCell)
    }
    
    func test_configurationCorrectAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", correctAnswer: "A1")])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_configurationWrongAnswerCell() {
        let sut = makeSUT(answers: [makeAnswer(question: "Q1", correctAnswer: "A1", wrongAnswer: "A2")])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "A2")
    }
    
    // MARK: Helpers
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    func makeAnswer(question: String = "", correctAnswer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question, correctAnswer: correctAnswer, wrongAnswer: wrongAnswer)
    }
}

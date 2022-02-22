//
//  QuizAppTests.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 15/02/2022.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    func test_viewDidLoad_rendersHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_RenderCorrectNumberOfOptions() {
        XCTAssertEqual(makeSUT(options: ["A1"]).optionsTableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "B1"]).optionsTableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(makeSUT(options: ["A1", "B1", "C1"]).optionsTableView.numberOfRows(inSection: 0), 3)
    }
    
    func test_viewDidLoad_RenderCorrectOptionsOnCell() {
        let sut = makeSUT(options: ["A1", "B1", "C1"])
        XCTAssertEqual(sut.optionsTableView.title(at: 0), "A1")
        XCTAssertEqual(sut.optionsTableView.title(at: 1), "B1")
        XCTAssertEqual(sut.optionsTableView.title(at: 2), "C1")
    }
    
    func test_viewDidLoad_singleSelection_configureTableView() {
        let sut = makeSUT(allowsMultipleSelection: false, callback: { _ in })
        XCTAssertFalse(sut.optionsTableView.allowsMultipleSelection)
    }
    
    func test_viewDidLoad_multipleSelections_configureTableView() {
        let sut = makeSUT(allowsMultipleSelection: true, callback: { _ in })
        XCTAssertTrue(sut.optionsTableView.allowsMultipleSelection)
    }
    
    func test_selectRow_singleSelection_callbackOptionsCorrectly() {
        var selectedAnswers: [String]?
        let sut = makeSUT(options: ["A1", "B1", "C1"], callback: {
            selectedAnswers = $0
        })
        
        sut.optionsTableView.selectRow(at: 0)
        XCTAssertEqual(selectedAnswers, ["A1"])
        
        sut.optionsTableView.selectRow(at: 1)
        XCTAssertEqual(selectedAnswers, ["B1"])
    }
    
    func test_selectRow_singleSeletion_callbackSingleTime() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "B1", "C1"], callback: { _ in
            callbackCount += 1
        })
        
        sut.optionsTableView.selectRow(at: 0)
        sut.optionsTableView.deselectRow(at: 0)
        sut.optionsTableView.selectRow(at: 1)
        XCTAssertEqual(callbackCount, 2)
    }
    
    func test_selectRows_multipleSelections_callbackOptionsCorrectly() {
        var selectedAnswers: [String]?
        let sut = makeSUT(options: ["A1", "B1", "C1"], allowsMultipleSelection: true, callback: {
            selectedAnswers = $0
        })
        
        sut.optionsTableView.selectRow(at: 0)
        sut.optionsTableView.selectRow(at: 1)
        XCTAssertEqual(selectedAnswers, ["A1", "B1"])
    }
    
    func test_deselectRows_multipleSelections_callbackOptionsCorrectly() {
        var selectedAnswers: [String]?
        let sut = makeSUT(options: ["A1", "B1", "C1"], allowsMultipleSelection: true, callback: {
            selectedAnswers = $0
        })
        
        sut.optionsTableView.selectRow(at: 0)
        sut.optionsTableView.selectRow(at: 1)
        sut.optionsTableView.deselectRow(at: 1)
        
        XCTAssertEqual(selectedAnswers, ["A1"])
    }
    
    // MARK: - Helpers
    func makeSUT(question: String = "",
                 options: [String] = [],
                 allowsMultipleSelection: Bool = false,
                 callback: @escaping (([String]) -> Void) = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, allowsMultipleSelection: allowsMultipleSelection, callback: callback)
        _ = sut.view
        
        return sut
    }
}

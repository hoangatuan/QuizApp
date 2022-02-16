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
        let sut = makeSUT(options: ["A1", "B1", "C1"], callback: {
            selectedAnswers = $0
        })
        sut.optionsTableView.allowsMultipleSelection = true
        
        sut.optionsTableView.selectRow(at: 0)
        sut.optionsTableView.selectRow(at: 1)
        XCTAssertEqual(selectedAnswers, ["A1", "B1"])
    }
    
    func test_deselectRows_multipleSelections_callbackOptionsCorrectly() {
        var selectedAnswers: [String]?
        let sut = makeSUT(options: ["A1", "B1", "C1"], callback: {
            selectedAnswers = $0
        })
        sut.optionsTableView.allowsMultipleSelection = true
        
        sut.optionsTableView.selectRow(at: 0)
        sut.optionsTableView.selectRow(at: 1)
        sut.optionsTableView.deselectRow(at: 0)
        
        XCTAssertEqual(selectedAnswers, ["B1"])
    }
    
    // MARK: - Helpers
    func makeSUT(question: String = "",
                 options: [String] = [],
                 callback: @escaping (([String]) -> Void) = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, callback: callback)
        _ = sut.view
        
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return self.dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let cell = cell(at: row)
        return cell?.textLabel?.text
    }
    
    func selectRow(at row: Int) {
        self.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
        self.delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
    
    func deselectRow(at row: Int) {
        self.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
        self.delegate?.tableView?(self, didDeselectRowAt: IndexPath(row: row, section: 0))
    }
}

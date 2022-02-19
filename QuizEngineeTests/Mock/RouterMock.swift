//
//  RouterMock.swift
//  QuizEngineeTests
//
//  Created by Hoang Anh Tuan on 17/02/2022.
//

import Foundation
import QuizEnginee

class RouterMock: Router { 
    var results: QuizResult<String, String>?
    var routedQuestions: [String] = []
    var callbackAnswer: ((String) -> Void) = { _ in }
    
    func routeTo(question: String, callback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        callbackAnswer = callback
    }
    
    func routeTo(results: QuizResult<String, String>) {
        self.results = results
    }
}

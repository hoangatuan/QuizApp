//
//  Flow.swift
//  QuizEnginee
//
//  Created by Hoang Anh Tuan on 13/02/2022.
//

import Foundation

protocol Router {
    func routeTo(question: String, callback: @escaping (String) -> Void)
    func routeTo(results: [String: String])
}

class Flow {
    private var results: [String: String] = [:]
    var router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        guard let question = questions.first else {
            router.routeTo(results: results)
            return
        }
        
        router.routeTo(question: question, callback: { [weak self] in
            self?.handleAnswerCallback(of: question, $0)
        })
    }
    
    func handleAnswerCallback(of question: String, _ answer: String) {
        guard let index = questions.firstIndex(of: question) else {
            return
        }
        results[question] = answer
        
        if index + 1 < questions.count {
            let nextQuestion = questions[index + 1]
            router.routeTo(question: nextQuestion,
                           callback: { [weak self] in
                self?.handleAnswerCallback(of: nextQuestion, $0)
            })
        } else {
            router.routeTo(results: results)
        }
    }
}

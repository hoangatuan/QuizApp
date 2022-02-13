//
//  Flow.swift
//  QuizEnginee
//
//  Created by Hoang Anh Tuan on 13/02/2022.
//

import Foundation

protocol Router {
    func routeTo(question: String, callback: @escaping (String) -> Void)
}

class Flow {
    var router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        guard let question = questions.first else {
            return
        }
        
        router.routeTo(question: question, callback: { [weak self] _ in
            self?.handleAnswerCallback(of: question)
        })
    }
    
    func handleAnswerCallback(of question: String) {
        guard let index = questions.firstIndex(of: question) else {
            return
        }
        
        if index + 1 < questions.count {
            let nextQuestion = questions[index + 1]
            router.routeTo(question: nextQuestion,
                           callback: { [weak self] _ in
                self?.handleAnswerCallback(of: nextQuestion)
            })
        }
    }
}

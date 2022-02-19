//
//  Flow.swift
//  QuizEnginee
//
//  Created by Hoang Anh Tuan on 13/02/2022.
//

import Foundation

class Flow<Question, Answer, R: Router> where Question == R.Question, Answer == R.Answer {
    private var results: [Question: Answer] = [:]
    var router: R
    private let questions: [Question]
    private var scoring: (([Question: Answer]) -> Int)
    
    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        guard let question = questions.first else {
            router.routeTo(results: QuizResult(answers: results, score: scoring(results)))
            return
        }
        
        router.routeTo(question: question, callback: { [weak self] in
            self?.handleAnswerCallback(of: question, $0)
        })
    }
    
    func handleAnswerCallback(of question: Question, _ answer: Answer) {
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
            router.routeTo(results: QuizResult(answers: results, score: scoring(results)))
        }
    }
}

//
//  ResultPresenter.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 20/02/2022.
//

import Foundation
import QuizEnginee

class ResultPresenter {
    private let result: QuizResult<Question<String>, [String]>
    private let questions: [Question<String>]
    private let correctAnswers: [Question<String>: [String]]
    
    init(questions: [Question<String>], result: QuizResult<Question<String>, [String]>, correctAnswers: [Question<String>: [String]]) {
        self.questions = questions
        self.result = result
        self.correctAnswers = correctAnswers
    }
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        questions.map { question in
            guard let correctAnswers = correctAnswers[question],
                  let userAnswers = result.answers[question] else {
                fatalError("Not found correct answer for this question: \(question)")
            }
            
            return generatePresentableAnswers(question: question, answers: userAnswers, correctAnswers: correctAnswers)
        }
    }
    
    private func generatePresentableAnswers(question: Question<String>, answers: [String], correctAnswers: [String]) -> PresentableAnswer {
        switch question {
        case .singleAnswer(let val), .multipleAnswer(let val):
            return PresentableAnswer(question: val,
                                     correctAnswer: formattedCorrectAnswer(correctAnswers),
                                     wrongAnswer: formattedWrongAnswer(answers, correctAnswers))
        }
    }
     
    private func formattedCorrectAnswer(_ correctAnswers: [String]) -> String {
        return correctAnswers.joined(separator: ", ")
    }
    
    private func formattedWrongAnswer(_ answers: [String], _ correctAnswers: [String]) -> String? {
        return correctAnswers == answers ? nil : answers.joined(separator: ", ")
    }
}

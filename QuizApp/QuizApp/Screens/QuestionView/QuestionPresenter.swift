//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 20/02/2022.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
        return "Question #\(index + 1)"
    }
}

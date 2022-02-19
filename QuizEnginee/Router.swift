//
//  Router.swift
//  QuizEnginee
//
//  Created by Hoang Anh Tuan on 17/02/2022.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, callback: @escaping (Answer) -> Void)
    func routeTo(results: QuizResult<Question, Answer>)
}

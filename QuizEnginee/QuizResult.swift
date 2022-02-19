//
//  QuizResult.swift
//  QuizEnginee
//
//  Created by Hoang Anh Tuan on 17/02/2022.
//

import Foundation

public struct QuizResult<Question: Hashable, Answer> {
    var answers: [Question: Answer]
    public var score: Int
}

//
//  Question.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import Foundation

public enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    public static func == (lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let val1), .singleAnswer(let val2)):
            return val1 == val2
        case (.multipleAnswer(let val1), .multipleAnswer(let val2)):
            return val1 == val2
        default:
            return false
        }
    }
}

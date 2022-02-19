//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import UIKit
import QuizEnginee

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answer: (String) -> Void) -> UIViewController
    func resultViewController(for result: QuizResult<Question<String>, String>) -> UIViewController
}

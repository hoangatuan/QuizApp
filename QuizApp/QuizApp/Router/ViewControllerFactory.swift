//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 19/02/2022.
//

import UIKit

protocol ViewControllerFactory {
    func questionViewController(for question: String, answer: (String) -> Void) -> UIViewController
}

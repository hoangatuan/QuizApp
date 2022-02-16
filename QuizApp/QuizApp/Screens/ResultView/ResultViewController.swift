//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 16/02/2022.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var summary: String?
    private var answers: [PresentableAnswer] = []
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = summary
        
        tableView.dataSource = self
        tableView.registerNib(type: CorrectAnswerCell.self)
        tableView.registerNib(type: WrongAnswerCell.self)
        tableView.allowsSelection = false
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return generateCorrectAnswerCell(from: answer, at: indexPath)
        }
        
        return generateWrongAnswerCell(from: answer, at: indexPath)
    }
    
    private func generateCorrectAnswerCell(from answer: PresentableAnswer, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(type: CorrectAnswerCell.self, at: indexPath)
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.correctAnswer
        return cell
    }
    
    private func generateWrongAnswerCell(from answer: PresentableAnswer, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(type: WrongAnswerCell.self, at: indexPath)
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.correctAnswer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}

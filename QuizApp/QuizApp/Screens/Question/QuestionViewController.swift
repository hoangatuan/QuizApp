//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 15/02/2022.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    // MARK: - Constants
    private let reuseIdentifier = "CELL"
    // MARK: - Variables
    private(set) var question: String?
    private(set) var options: [String] = []
    private var allowsMultipleSelection: Bool = false
    var callbackAnswer: (([String]) -> Void)?
    
    convenience init(question: String, options: [String],
                     allowsMultipleSelection: Bool = false,
                     callback: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.allowsMultipleSelection = allowsMultipleSelection
        self.callbackAnswer = callback
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = question
        
        optionsTableView.allowsMultipleSelection = allowsMultipleSelection
        optionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
    }
    
    private func getSelectedOptions() -> [String] {
        guard let indexPaths = optionsTableView.indexPathsForSelectedRows else {
            return []
        }
        
        return indexPaths.map { options[$0.row] }
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callbackAnswer?(getSelectedOptions())
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            callbackAnswer?(getSelectedOptions())
        }
    }
}

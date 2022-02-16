//
//  UITableView+.swift
//  QuizAppTests
//
//  Created by Hoang Anh Tuan on 16/02/2022.
//

import UIKit

extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return self.dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let cell = cell(at: row)
        return cell?.textLabel?.text
    }
    
    func selectRow(at row: Int) {
        self.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
        self.delegate?.tableView?(self, didSelectRowAt: IndexPath(row: row, section: 0))
    }
    
    func deselectRow(at row: Int) {
        self.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
        self.delegate?.tableView?(self, didDeselectRowAt: IndexPath(row: row, section: 0))
    }
}


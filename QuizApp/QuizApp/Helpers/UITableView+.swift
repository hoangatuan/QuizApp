//
//  UITableView+.swift
//  QuizApp
//
//  Created by Hoang Anh Tuan on 16/02/2022.
//

import UIKit

extension UITableView {
    func registerNib(type: UITableViewCell.Type) {
        register(UINib(nibName: String(describing: type), bundle: nil),
                 forCellReuseIdentifier: String(describing: type))
    }
    
    func dequeReusableCell<T>(type: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
}

//
//  PeopleListContentView.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

class PeopleListContentView: UIView {

    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        setupTableView()
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    private func setupTableView() {
        tableView.backgroundColor = .clear
    }
    
    private func layoutUI() {
        let views = [tableView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

//
//  PeopleListContentView.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

class PeopleListContentView: UIView {

    let tableView = UITableView()
    let imageView = UIImageView()
    
    let refreshControl = UIRefreshControl()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        setupTableView()
        
        setupImageViews()
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageViews(){
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageConstant.peopleListEmpty
        imageView.isHidden = true
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.addSubview(refreshControl)
        refreshControl.attributedTitle = NSAttributedString(string: StringConstant.pullToRefresh)

    }
    
    private func layoutUI() {
        let views = [imageView, tableView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ViewSizeConstant.personListContentViewEmptyImageViewSize.height),
            imageView.widthAnchor.constraint(equalToConstant: ViewSizeConstant.personListContentViewEmptyImageViewSize.width),
            
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

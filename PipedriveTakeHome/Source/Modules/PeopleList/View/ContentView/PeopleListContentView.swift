//
//  PeopleListContentView.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

class PeopleListContentView: UIView {

    // MARK: Views
    let tableView = UITableView()
    let imageView = UIImageView()
    let refreshControl = UIRefreshControl()


    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
               
        /// Configure the table view
        setupTableView()
        
        /// Configure the image view
        setupImageViews()
        
        /// Apply the layout constraints
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    /// Setups up the no internet view when this function is called by setting no internet image to imageview and setting the imageview visible
    func setupNoInternetView(){
        imageView.image = ImageConstant.peopleListNoInternet
        imageView.isHidden = false
    }
    
    /// Setups up the no empty list view when this function is called by setting empty list image to imageview and setting the imageview visible
    func setupEmptyListView(){
        imageView.image = ImageConstant.peopleListEmpty
        imageView.isHidden = false
    }
    
    // MARK: Private functions
    
    /// Setup Imageview properties and appearence
    private func setupImageViews(){
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageConstant.peopleListEmpty
        imageView.isHidden = true
    }
    
    /// Setup Tableview properties and appearence
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.addSubview(refreshControl)
        refreshControl.attributedTitle = NSAttributedString(string: StringConstant.pullToRefresh)

    }
    
    
    /// Layout the UI elements imageview and tableview
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

//
//  PersonDetailContentView.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit

class PersonDetailContentView: UIView {

    // MARK: Views
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let organizationLabel = UILabel()
    let tableViewContainer = UIView()
    let tableView = UITableView()
    let emptyImageView = UIImageView()
    
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        /// Calls the setupView() function to configure the view's background color.
        setupView()
        
        /// Calls the setupLabels() function to configure the appearance of the nameLabel and organizationLabel.
        setupLabels()
        
        /// Calls the setupImageViews() function to configure the appearance of the profileImageView and emptyImageView.
        setupImageViews()
        
        /// Calls the setupTableView() function to configure the appearance and constraints of the tableView.
        setupTableView()
        
        /// Calls the layoutUI() function to set up the layout constraints for all the subviews.
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private functions
    
    /// Configures the background color of the view.
    private func setupView(){
        backgroundColor = .systemBackground
    }
    
    /// Configures the appearance of the nameLabel and organizationLabel.
    private func setupLabels(){
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        organizationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        organizationLabel.textColor = .secondaryLabel
        nameLabel.textAlignment = .center
        organizationLabel.textAlignment = .center
        
        
    }
    
    /// Configures the appearance of the profileImageView and emptyImageView.
    private func setupImageViews(){
        profileImageView.layer.cornerRadius = ViewSizeConstant.personDetailContentViewProfileImageSize.height / 2
        profileImageView.image = ImageConstant.profilePlaceholder
        profileImageView.clipsToBounds = true
        
        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.image = ImageConstant.peopleListEmpty
        emptyImageView.isHidden = true
    }
    
    /// Configures the appearance and constraints of the tableView.
    private func setupTableView() {
        tableViewContainer.backgroundColor = .secondarySystemBackground
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor, constant: -16)
            
        ])
    }
    
    
    /// Sets up the layout constraints for all the subviews.
    private func layoutUI(){
        
        let views = [profileImageView, nameLabel, organizationLabel, tableViewContainer, emptyImageView]
        
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: ViewSizeConstant.personDetailContentViewProfileImageSize.height),
            profileImageView.widthAnchor.constraint(equalToConstant: ViewSizeConstant.personDetailContentViewProfileImageSize.width),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            organizationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            organizationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            organizationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            tableViewContainer.topAnchor.constraint(equalTo: organizationLabel.bottomAnchor, constant: 16),
            tableViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableViewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            emptyImageView.centerYAnchor.constraint(equalTo: tableViewContainer.safeAreaLayoutGuide.centerYAnchor),
            emptyImageView.centerXAnchor.constraint(equalTo: tableViewContainer.centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: ViewSizeConstant.personListContentViewEmptyImageViewSize.height),
            emptyImageView.widthAnchor.constraint(equalToConstant: ViewSizeConstant.personListContentViewEmptyImageViewSize.width),

        ])
        
    }

}

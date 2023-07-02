//
//  PersonCell.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

class PersonCell: UITableViewCell {

    static let reuseID = "PersonCell"

    
    // MARK: Views
    
    private let containerView = UIView()
    private let nameLabel = UILabel()
    private let organizationLabel = UILabel()
    private let profileImageView = UIImageView()
    private let labelStackView = UIStackView()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
        setupLabels()
        
        setupImageViews()
        
        setupLabelStackView()
        
        setupContainerView()
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    /// Defines a method named `set(person:)` to set the values of the labels and imageviews based on a given Person object.
    /// - Parameter contact: Person used to set cells data
    func set(person: Person){
        nameLabel.text = person.name
        organizationLabel.text = person.organizationName ?? "NA"
        profileImageView.setImageWithUrl(url: person.picture?.pictures?.smallImage ?? "")
    }
    
    
    // MARK: Private Functions
    
    private func setupView() {
        /// Set the background color of the cell to clear
        self.backgroundColor = .clear
        
        /// Disable the selection style of the cell
        self.selectionStyle = .none
    }
    
    private func setupLabels() {
        /// Set the font styles for the labels
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        organizationLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    private func setupImageViews() {
        /// Set the corner radius and background color of the profile image view
        profileImageView.layer.cornerRadius = ViewSizeConstant.personCellProfileImageSize.height / 2
        profileImageView.clipsToBounds = true
    }
    
    private func setupLabelStackView() {
        /// Add the name and species labels to the stack view
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(organizationLabel)
        
        /// Set the axis and distribution properties of the stack view
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalCentering
    }
    
    private func setupContainerView() {
        /// Set the background color of the container view
        containerView.backgroundColor = .secondarySystemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            /// Set constraints to position the container view within the cell
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    /// Setup layout constraints of profileImageView and labelStackView
    private func layoutUI() {
        let views = [profileImageView, labelStackView]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            
            profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: ViewSizeConstant.personCellProfileImageSize.width),
            profileImageView.heightAnchor.constraint(equalToConstant: ViewSizeConstant.personCellProfileImageSize.height),
            
            labelStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            labelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
}

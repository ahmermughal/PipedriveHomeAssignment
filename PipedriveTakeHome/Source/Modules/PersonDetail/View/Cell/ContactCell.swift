//
//  ContactCell.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit

class ContactCell: UITableViewCell {

    
    /// Declares a static constant reuseID of type String, representing the reuse identifier for the table view cell.
    static let reuseID = "ContactCell"

    // MARK: Views
    
    /// Declares two properties: typeLabel and contactLabel, both of type UILabel.
    /// These labels will display the type of contact and the contact information.
    let typeLabel = UILabel()
    let contactLabel = UILabel()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /// Calls the configure() method to set the cell's selection style.
        configure()

        /// Calls the setupLabels() method to configure the appearance of the labels.
        setupLabels()

        /// Calls the layoutUI() method to set up the layout constraints for the labels.
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Functions
    
    /// Defines a method named `set(contact:)` to set the values of the labels based on a given PersonContact object.
    /// - Parameter contact: PersonContact  used to set cells data
    func set(contact: PersonContact) {

        /// Sets the text of the typeLabel to the label value of the PersonContact object.
        typeLabel.text = contact.label

        /// Sets the text of the contactLabel to the value of the PersonContact object.
        contactLabel.text = contact.value
    }

    // MARK: Private functions

    private func configure() {

        /// Sets the cell's selection style to none, so it doesn't highlight when selected.
        selectionStyle = .none
    }

    /// Private method to configure the appearance of the labels.
    private func setupLabels() {

        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption2)

        typeLabel.textColor = .secondaryLabel

        contactLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }

    /// Private method to set up the layout constraints for the labels.
    private func layoutUI() {

        let views = [typeLabel, contactLabel]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
            typeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            contactLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 4),
            contactLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            contactLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        
        ])
    }
}

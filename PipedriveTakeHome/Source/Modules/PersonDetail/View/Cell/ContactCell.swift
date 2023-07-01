//
//  ContactCell.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit

class ContactCell: UITableViewCell {

    static let reuseID = "ContactCell"

    let typeLabel = UILabel()
    let contactLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        
        setupLabels()
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(contact: PersonContact){
        typeLabel.text = contact.label
        contactLabel.text = contact.value
    }
    
    private func configure(){
        selectionStyle = .none
    }
    
    private func setupLabels(){
     
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        typeLabel.textColor = .secondaryLabel
        
        contactLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
    }
    
    private func layoutUI(){
        
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

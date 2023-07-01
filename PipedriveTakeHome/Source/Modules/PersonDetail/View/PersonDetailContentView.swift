//
//  PersonDetailContentView.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit

class PersonDetailContentView: UIView {

    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let organizationLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        
        setupLabels()
        
        setupImageViews()
        
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        backgroundColor = .systemBackground
    }
    
    private func setupLabels(){
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        organizationLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        organizationLabel.textColor = .secondaryLabel
        nameLabel.textAlignment = .center
        organizationLabel.textAlignment = .center
        
        
    }
    
    private func setupImageViews(){
        profileImageView.layer.cornerRadius = ViewSizeConstant.personDetailContentViewProfileImageSize.height / 2
        profileImageView.backgroundColor = .red
        profileImageView.clipsToBounds = true
        
        
    }
    
    private func layoutUI(){
        
        let views = [profileImageView, nameLabel, organizationLabel]
        
        
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


            
        
        ])
        
    }

}

//
//  PersonDetailVC.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit

class PersonDetailVC: UIViewController {

    private let contentView = PersonDetailContentView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height))
    
    private let viewModel : PersonDetailViewModel
    
    
    init(viewModel: PersonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    
    private func configureUI(){
        
        contentView.nameLabel.text = viewModel.person.name
        contentView.organizationLabel.text = viewModel.person.organizationName
        contentView.profileImageView.setImageWithUrl(url: viewModel.person.picture?.pictures?.largeImage ?? "")

    }



}

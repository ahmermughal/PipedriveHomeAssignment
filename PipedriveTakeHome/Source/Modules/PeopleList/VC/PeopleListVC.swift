//
//  PeopleListVC.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit

class PeopleListVC: UIViewController {

    private let contentView = PeopleListContentView()
    
    private let viewModel : PeopleListViewModel
    
    
    init(viewModel : PeopleListViewModel = PeopleListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }
    
    
    private func configureVC(){
        
        title = StringConstant.people

        
    }
    
    



}

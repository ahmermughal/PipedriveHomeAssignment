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
        configureTableView()
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
    
    private func configureTableView(){
        contentView.tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
    }
    
}

extension PersonDetailVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList[section].contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID) as? ContactCell {
            
            let contact = viewModel.contactList[indexPath.section].contact[indexPath.row]
            cell.set(contact: contact)
            
            return cell
        }else {
            return UITableViewCell()
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.contactList[section].title
    }
    
}

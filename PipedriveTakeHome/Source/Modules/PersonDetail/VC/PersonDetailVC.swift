//
//  PersonDetailVC.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit
import Combine

class PersonDetailVC: UIViewController {

    // MARK: Variables
    
    /// Creates an instance of PersonDetailContentView with a specific frame.
    private let contentView = PersonDetailContentView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height))
    
    /// A collection of AnyCancellable objects used to store subscriptions to Combine publishers.
    private var subscriptions: [AnyCancellable] = []

    /// The view model for the PersonDetailVC.
    private let viewModel : PersonDetailViewModel
    
    // MARK: Init
    
    init(viewModel: PersonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override functions
    
    /// Sets the contentView as the view of the view controller.
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Configures the UI elements of the contentView.
        configureUI()
        
        /// Configures the tableView in the contentView.
        configureTableView()
        
        /// Sets up bindings between the view model and the view controller.
        setupBinding()
        
    }
    
    // MARK: Private functions
    
    /// Configures the UI elements of the contentView.
    private func configureUI(){
        
        contentView.nameLabel.text = viewModel.person.name
        contentView.organizationLabel.text = viewModel.person.organizationName
        contentView.profileImageView.setImageWithUrl(url: viewModel.person.picture?.pictures?.largeImage ?? "")
    }
    
    /// Sets up bindings between the view model and the view controller.
    private func setupBinding(){
        
        viewModel.$listIsEmpty
            .subscribe(on: DispatchQueue.main)
            .compactMap{$0}
            .sink(receiveValue: handleListIsEmpty)
            .store(in: &subscriptions)
        
    }
    
    /// Configures the tableView in the contentView.
    private func configureTableView(){
        contentView.tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.separatorStyle = .none
    }
    
    /// Handles the listIsEmpty property of the view model.
    private func handleListIsEmpty(empty: Bool){
        contentView.emptyImageView.isHidden = !empty
    }
}

// MARK: UITableViewDataSource and UITableViewDelegate
extension PersonDetailVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList[section].contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// Dequeues a reusable cell with the reuse identifier ContactCell.reuseID and casts it as ContactCell.
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID) as? ContactCell {
            
            /// Retrieves the contact from the contactList in the view model at the specified index path.
            let contact = viewModel.contactList[indexPath.section].contact[indexPath.row]
           /// Configures the cell with the contact data.
            cell.set(contact: contact)
            
            return cell
        }else {
            /// Returns a default UITableViewCell if dequeuing or casting fails.
            return UITableViewCell()
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        /// Returns the number of sections in the tableView, based on the contactList in the view model.
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        /// Returns the title for the specified section of the tableView, based on the contactList in the view model.
        return viewModel.contactList[section].title
    }
    
}

//
//  PeopleListVC.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit
import Combine

class PeopleListVC: UIViewController {

    private let contentView = PeopleListContentView()
    
    private var subscriptions: [AnyCancellable] = []

    private var dataSource: UITableViewDiffableDataSource<Section, String>!
    
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
        
        configureTableView()
        
        configureDataSource()
        
        setupBinding()
        
        viewModel.getPeople()
        
        NetworkManager.shared.getAllPersons()
            .sink { result in
                print("Result: \(result)")
            } receiveValue: { response in
                print("Response: \(response)")
            }
            .store(in: &subscriptions)

        
    }
    
    
    private func configureVC(){
        
        title = StringConstant.people
        
    }
    
    private func setupBinding(){
        
        viewModel.$peopleList
            .sink(receiveValue: handlePeopleListData)
            .store(in: &subscriptions)
        
    }
    
    private func configureTableView(){
        
        contentView.tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseID)
                
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, value in
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseID, for: indexPath) as! PersonCell
            
            /// Set the character data for the cell
            cell.set(name: value, org: "Test1")
            
            return cell
        })
    }
    
    
    private func handlePeopleListData(listData: [String]){
       updateData(on: listData)
    }
    
    private func updateData(on list: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        /// Append the main section and its items to the snapshot
        snapshot.appendSections([.main])
        snapshot.appendItems(list)
        
        /// Apply the snapshot to the data source on the main queue
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }


}

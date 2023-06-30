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

    private var dataSource: UITableViewDiffableDataSource<Section, Person>!
    
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
        
        
    }
    
    
    private func configureVC(){
        
        title = StringConstant.people
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func setupBinding(){
        
        viewModel.$peopleList
            .sink(receiveValue: handlePeopleListData)
            .store(in: &subscriptions)
        
    }
    
    private func configureTableView(){
        
        contentView.tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseID)
                
        contentView.tableView.separatorStyle = .none

    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, value in
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseID, for: indexPath) as! PersonCell
            
            cell.set(person: value)
            
            return cell
        })
    }
    
    
    private func handlePeopleListData(listData: [Person]){
       updateData(on: listData)
    }
    
    private func updateData(on list: [Person]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
        
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

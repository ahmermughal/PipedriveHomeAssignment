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
        
        setupBinding()
        
        viewModel.getPeople()
        
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
        
        contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TestReuseID")
        
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
    
    private func handlePeopleListData(listData: [String]){
        contentView.tableView.reloadData()
    }
    
    


}

extension PeopleListVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TestReuseID"){
            cell.textLabel?.text = viewModel.peopleList[indexPath.row]
            return cell
        }else{
            
            return UITableViewCell()
        }
        
    }
    
    
}

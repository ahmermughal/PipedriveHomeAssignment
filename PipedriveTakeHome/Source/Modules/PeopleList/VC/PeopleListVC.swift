//
//  PeopleListVC.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit
import Combine

class PeopleListVC: DataLoadingViewController {

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
        
        setupListeners()
        
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
        
        viewModel.$showLoader
            .subscribe(on: DispatchQueue.main)
            .compactMap{$0}
            .sink(receiveValue: handleShowLoader)
            .store(in: &subscriptions)

        
        viewModel.$state
            .subscribe(on: DispatchQueue.main)
            .compactMap{$0}
            .sink(receiveValue: handleState)
            .store(in: &subscriptions)

        
    }
    
    private func setupListeners(){
        
        contentView.refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
    }
    
    private func configureTableView(){
        
        contentView.tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseID)
                
        contentView.tableView.separatorStyle = .none
        
        contentView.tableView.delegate = self
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
    
    private func handleListIsEmpty(empty: Bool){
        contentView.imageView.isHidden = !empty
    }
    
    private func handleState(state: PeopleListState){
        
        switch state {
        case .empty:
            contentView.setupEmptyListView()
        case .noInternet:
            contentView.setupNoInternetView()
        case .allGood:
            contentView.imageView.isHidden = true
        }
        
        
    }
    
    private func handleShowLoader(show: Bool){
        if show{
            showLoadingView()
        }else{
            contentView.refreshControl.endRefreshing()
            dismissLoadingView()
        }
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
    
    private func pushToPersonDetailVC(person: Person){
        let vm = PersonDetailViewModel(person: person)
        let vc = PersonDetailVC(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func refreshTableView(){
        viewModel.resetData()
        viewModel.getPeople()
    }

}

extension PeopleListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = viewModel.peopleList[indexPath.row]
        pushToPersonDetailVC(person: person)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            
            guard viewModel.hasNext, !viewModel.isLoadingNext else {
                return
            }
            
            viewModel.getPeople()
        }
    }
    
}

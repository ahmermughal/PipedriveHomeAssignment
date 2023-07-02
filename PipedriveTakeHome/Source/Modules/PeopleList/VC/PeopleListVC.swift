//
//  PeopleListVC.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 30/06/2023.
//

import UIKit
import Combine

class PeopleListVC: DataLoadingViewController {

    // MARK: Varaibles
    
    private let contentView = PeopleListContentView()
    
    private var subscriptions: [AnyCancellable] = []

    private var dataSource: UITableViewDiffableDataSource<Section, Person>!
    
    private let viewModel : PeopleListViewModel
    
    // MARK: Init
    
    init(viewModel : PeopleListViewModel = PeopleListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override Functions
    
    /// Set the PeopleListContentView instance as the view of the view controller
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Configure the view controller/
        configureVC()
        
        /// Configure the table view/
        configureTableView()
        
        /// Configure the data source/
        configureDataSource()
        
        /// Set up bindings with the view model/
        setupBinding()
        
        /// Set up listeners for events/
        setupListeners()
        
        /// Fetch the initial list of people/
        viewModel.getPeople()
        
    }
    
    // MARK: Private functions
    
    private func configureVC(){
        
        title = StringConstant.people
        
        /// Set the preference for large titles in the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    /// Sets up bindings between the view model and the view controller.
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
    
    /// Setup listerns to listen for changes when tableview is pulled down to refresh
    private func setupListeners(){
        
        contentView.refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
    }
    
    private func configureTableView(){
        
        contentView.tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseID)
                
        contentView.tableView.separatorStyle = .none
        
        contentView.tableView.delegate = self
    }
    
    /// Setup TableViewDiffiableDataSource to display data in the tableview
    /// DiffiableDataSource is used so tableview can be updated when new data is loaded in pagination
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, value in
            
            /// Dequeue a reusable cell with the identifier and cast it to PersonCell
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseID, for: indexPath) as! PersonCell
            
            /// Set the person data for the cell/
            cell.set(person: value)
            
            return cell
        })
    }
    
    /// Update the data displayed in the table view/
    private func handlePeopleListData(listData: [Person]){
       updateData(on: listData)
    }
    
    /// Hide or show the image view based on whether the list is empty or not
    private func handleListIsEmpty(empty: Bool){
        contentView.imageView.isHidden = !empty
    }
    
    private func handleState(state: PeopleListState){
        
        switch state {
        case .empty:
            /// Set up the view to represent an empty list state
            contentView.setupEmptyListView()
        case .noInternet:
            /// Set up the view to represent a no internet state
            contentView.setupNoInternetView()
        case .allGood:
            // Hide the image view
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
        /// Reset the data in the view model/
        viewModel.resetData()
        /// Fetch the updated list of people/
        viewModel.getPeople()
    }

}

// MARK: UITableViewDelegate
extension PeopleListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Get the selected person from the people list
        let person = viewModel.peopleList[indexPath.row]
        /// Push to the person detail view controller with the selected person
        pushToPersonDetailVC(person: person)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        /// Get the vertical content offset of the scroll view
        let offsetY = scrollView.contentOffset.y
        /// Get the height of the scrollable content
        let contentHeight = scrollView.contentSize.height
        /// Get the visible height of the scroll view
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            
            guard viewModel.hasNext, !viewModel.isLoadingNext else {
                return
            }
            
            /// Fetch the next set of people when reaching the end of the table view
            viewModel.getPeople()
        }
    }
    
}

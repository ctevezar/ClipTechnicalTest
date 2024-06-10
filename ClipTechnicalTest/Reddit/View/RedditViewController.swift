//
//  RedditViewController.swift
//  ClipTechnicalTest
//
//  Created by Carlos Tevez on 06/06/2024.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayPosts(viewModel: Reddit.FetchTopPosts.ViewModel)
}

class RedditViewController: UIViewController, HomeDisplayLogic {
    var interactor: RedditTopPostsBusinessLogic?
    
    private var displayedPosts: [Reddit.FetchTopPosts.ViewModel.DisplayedPost] = []
    private var filteredTableData: [Reddit.FetchTopPosts.ViewModel.DisplayedPost] = []
    
    // MARK:  Private Vars
    private var isSearching = false
    
    private lazy var searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search".localized
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var tableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        table.backgroundColor = .systemGray
        
        return table
    }()
    
    private lazy var searchEmptyStateView: UIView = {
        let icon = UIImage(named: "SearchEmptyState")
        let title = "We did not find results".localized
        let description = "Try another keyword".localized
        let data = InfoData(image: icon, title: title, description: description)
        
        let view = InfoView(with: data)
        
        return view
    }()
    
    private lazy var searchInstructionView: UIView = {
        let icon = UIImage(named: "SearchInstruction")
        let title = "Search something".localized
        let description = "pepe"
        let data = InfoData(image: icon, title: title, description: description)
        
        let view = InfoView(with: data)
        
        return view
    }()
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = RedditTopPostsInteractor()
        let presenter = RedditTopPostsPresenter()
        let worker = RedditWorker()
        
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        interactor.worker = worker
        
        presenter.viewController = viewController
    }
    
    // MARK: Routing
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getPosts()
    }
    
    // MARK:  Private methods
    private func setupUI() {
        configureUI()
        addSubviews()
        configureLayout()
        configureGesture()
    }
    
    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
        
        if searchBar.isTextEmpty {
            isSearching = false
            reloadData()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationItem.titleView = searchBar
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Public Methods
    func displayFilteredPosts() {
        tableView.backgroundView = filteredTableData.isEmpty ? searchEmptyStateView : nil
        reloadData()
    }
    
    // MARK: Private Methods
    // MARK: Posts
    private func getPosts() {
        interactor?.fetchTopPosts()
    }
    
    func displayPosts(viewModel: Reddit.FetchTopPosts.ViewModel) {
        displayedPosts = viewModel.displayedPosts
        if displayedPosts.isEmpty {
            tableView.backgroundView = searchEmptyStateView
        }
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    // MARK: Search
    private func searchBy(word searchText: String) {
        if searchText.isEmpty {
            filteredTableData = []
            showSearchInstructionView()
            
            return
        }
        
        filteredTableData = displayedPosts.filter({ post -> Bool in
            if let title = post.title?.lowercased() {
                return title.contains(searchText.lowercased())
            }
            return false
        })
        
        displayFilteredPosts()
    }
    
    private func showSearchInstructionView() {
        tableView.backgroundView = searchInstructionView
        reloadData()
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
}

// MARK: TableView
extension RedditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredTableData.count : displayedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostTableViewCell
        else { return UITableViewCell() }
        
        let data = isSearching ? filteredTableData[indexPath.row] : displayedPosts[indexPath.row]
        cell.configure(with: data, indexPath: indexPath)
        
        return cell
    }
}

extension RedditViewController: UITableViewDelegate {
    
}

// MARK: SearchBar
extension RedditViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchBy(word: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        if searchBar.isTextEmpty {
            showSearchInstructionView()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = !searchBar.isTextEmpty
    }
}

//
//  DataTableViewController.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import UIKit

class DataTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        viewModel.filterCharacters(query: query) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCharacterCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = viewModel.getCurrentCharacter(index: indexPath.row)
        viewModel.showDetails(character: character)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.cellIdentifier, for: indexPath) as? DataTableViewCell else {
            fatalError()
        }
        let character = viewModel.getCurrentCharacter(index: indexPath.row)
        cell.configure(character: character, imageServices: imageServices)
        return cell
    }
    
    

    private var imageServices : ImageServicing
    private var viewModel : DataTableViewModel
    
    init(imageServices: ImageServicing, viewModel: DataTableViewModel) {
        self.imageServices = imageServices
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(DataTableViewCell.self, forCellReuseIdentifier: DataTableViewCell.cellIdentifier)
        return table
    }()
    
    private var searchController : UISearchController!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView27"
        setUpTable()
        setUpSearchController()
        viewModel.getAllCharacters {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        
    }
    
    private func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    private func setUpSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Character"
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}

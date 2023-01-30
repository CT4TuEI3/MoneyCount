//
//  ExpensesVC.swift
//  MoneyCount
//
//  Created by Алексей on 30.01.2023.
//

import UIKit

final class ExpensesVC: UIViewController {
    
    // MARK: - Private propertyes
    
    private let expensesIdentifire = "expensesIdentifire"
    
    
    // MARK: - UI Elements
    
    private let expensesTableView = UITableView()
    private let expensesSearchBar = UISearchBar()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        searchBarSettings()
        settingsTableView()
        setConstrains()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(expensesTableView)
        view.addSubview(expensesSearchBar)
    }
    
    private func settingsTableView() {
        expensesTableView.translatesAutoresizingMaskIntoConstraints = false
        expensesSearchBar.translatesAutoresizingMaskIntoConstraints = false
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        expensesTableView.rowHeight = 64
        expensesTableView.register(ExpensesCell.self, forCellReuseIdentifier: expensesIdentifire)
    }
    
    private func searchBarSettings() {
        expensesSearchBar.delegate = self
    }
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            expensesSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            expensesSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expensesSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            expensesTableView.topAnchor.constraint(equalTo: expensesSearchBar.bottomAnchor),
            expensesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expensesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            expensesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
    }
}


// MARK: UISearchBarDelegate

extension ExpensesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


// MARK: UITableViewDelegate, UITableViewDataSource

extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: expensesIdentifire,
                                                 for: indexPath) as? ExpensesCell
        return cell ?? UITableViewCell()
    }
}

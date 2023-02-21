//
//  ExpensesVC.swift
//  MoneyCount
//
//  Created by Алексей on 30.01.2023.
//

import UIKit

protocol ExpensesVCDelegate: AnyObject {
    func updatedNavBarBtn()
}

final class ExpensesVC: UIViewController {
    
    // MARK: - Internal propertyes
    
    weak var delegate: ExpensesVCDelegate?
    
    
    // MARK: - Private propertyes
    
    private let firebaseService = FireBaseService()
    private let expensesIdentifire = "expensesIdentifire"
    private var moneyCount: MoneyCountModel?
    
    
    // MARK: - UI Elements
    
    private let expensesTableView = UITableView()
    private let expensesSearchBar = UISearchBar()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseService.getData { [weak self] result in
            switch result {
                case .success(let success):
                    self?.moneyCount = success
                    self?.expensesTableView.reloadData()
                    
                case .failure(let failure):
                    print(failure)
            }
        }
        setupUI()
        searchBarSettings()
        settingsTableView()
        setConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.updatedNavBarBtn()
        expensesTableView.reloadData()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(expensesTableView)
        view.addSubview(expensesSearchBar)
    }
    
    private func settingsTableView() {
        expensesTableView.translatesAutoresizingMaskIntoConstraints = false
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        expensesTableView.keyboardDismissMode = .onDrag
        expensesTableView.backgroundColor = .systemGray6
        expensesTableView.register(ExpensesCell.self, forCellReuseIdentifier: expensesIdentifire)
    }
    
    private func searchBarSettings() {
        expensesSearchBar.translatesAutoresizingMaskIntoConstraints = false
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
            expensesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: UISearchBarDelegate

extension ExpensesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


// MARK: UITableViewDelegate, UITableViewDataSource

extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moneyCount?.expence.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let expence = moneyCount?.expence[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: expensesIdentifire,
                                                 for: indexPath) as? ExpensesCell
        cell?.configure(expence: expence,
                        name: expence.names[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = moneyCount else { return }
        navigationController?.pushViewController(CardExpense(title: model.expence[indexPath.row].title,
                                                             amountExp: model.expence[indexPath.row].amount,
                                                             date: model.expence[indexPath.row].date,
                                                             name: model.names ),
                                                 animated: true)
    }
}

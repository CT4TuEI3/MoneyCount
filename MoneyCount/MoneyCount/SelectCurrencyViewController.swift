//
//  SelectCurrencyViewController.swift
//  MoneyCount
//
//  Created by Алексей on 21.01.2023.
//

import UIKit

final class SelectCurrencyViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let currencyCellIdentifier = "currencyCell"
    
    
    //MARK: - UI elements
    
    private let currencyTableView = UITableView()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(currencyTableView)
        settingsCurrencyTableView()
        setConstraints()
    }
    
    private func settingsCurrencyTableView() {
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        currencyTableView.register(UITableViewCell.self, forCellReuseIdentifier: currencyCellIdentifier)
        currencyTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            currencyTableView.topAnchor.constraint(equalTo: view.topAnchor),
            currencyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellIdentifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

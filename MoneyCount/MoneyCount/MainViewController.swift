//
//  ViewController.swift
//  MoneyCount
//
//  Created by Алексей on 17.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private propertyes
    
    private let cellIdentifire = "Title"
    
    
    // MARK: - UI Elements
    
    private let moneyCountTableView = UITableView()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "MoneyCount"
        view.backgroundColor = .systemBackground
        view.addSubview(moneyCountTableView)
        settingsTable()
        setConstraints()
    }
    
    private func settingsTable() {
        moneyCountTableView.delegate = self
        moneyCountTableView.dataSource = self
        moneyCountTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
        moneyCountTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moneyCountTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moneyCountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moneyCountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moneyCountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        cell.backgroundColor = .systemBackground
        return cell
    }
}

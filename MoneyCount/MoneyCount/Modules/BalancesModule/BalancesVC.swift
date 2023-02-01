//
//  BalancesVC.swift
//  MoneyCount
//
//  Created by Алексей on 1.02.2023.
//

import UIKit

final class BalancesVC: UIViewController {
    
    // MARK: - Private propertyes

    private let balancesCellIddentifire = "balancesCellIddentifire"
    
    
    // MARK: - UI Elements

    private let balanceNamesTable = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(balanceNamesTable)
        settingsTable()
        setConstraints()
        
    }
    
    private func settingsTable() {
        balanceNamesTable.delegate = self
        balanceNamesTable.dataSource = self
        balanceNamesTable.register(BalacesCell.self, forCellReuseIdentifier: balancesCellIddentifire)
    }
    
    private func setConstraints() {
        balanceNamesTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            balanceNamesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            balanceNamesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            balanceNamesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            balanceNamesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: UITableViewDelegate, UITableViewDataSource

extension BalancesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: balancesCellIddentifire,
                                                 for: indexPath) as? BalacesCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemGray6
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}

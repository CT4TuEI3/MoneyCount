//
//  BalancesVC.swift
//  MoneyCount
//
//  Created by Алексей on 1.02.2023.
//

import UIKit

protocol BalancesVCDelegate: AnyObject {
    func updateNavBar()
}

final class BalancesVC: UIViewController {
    
    // MARK: - Internal propertyes
    
    weak var delegate: BalancesVCDelegate?
    
    
    // MARK: - Private propertyes

    private let names: [NameBalanceModel]
    private let balancesCellIddentifire = "balancesCellIddentifire"
    
    
    // MARK: - UI Elements

    private let balanceNamesTable = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life cycle

    init(names: [NameBalanceModel]) {
        self.names = names
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.updateNavBar()
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
        names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: balancesCellIddentifire,
                                                 for: indexPath) as? BalacesCell
        cell?.configure(names: names[indexPath.row].name)
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

//
//  CardExpense.swift
//  MoneyCount
//
//  Created by Алексей on 6.02.2023.
//

import UIKit

final class CardExpense: UIViewController {
    
    // MARK: - Private propertyes
    
    private let namesTVCellIdentifire = "namesTVCellIdentifire"
    
    
    // MARK: - UI Elements
    
    private let customHeader = UIView()
    private let namesTableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(namesTableView)
        settingsTableView()
        setConstraints()
    }
    
    private func settingsTableView() {
        namesTableView.delegate = self
        namesTableView.dataSource = self
        namesTableView.register(CardExpenseCell.self, forCellReuseIdentifier: namesTVCellIdentifire)
    }
    
    private func setConstraints() {
        namesTableView.translatesAutoresizingMaskIntoConstraints = false
        customHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            namesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            namesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            namesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CardExpense: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: namesTVCellIdentifire,
                                                 for: indexPath) as? CardExpenseCell ?? UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        CustomHeader(color: .systemBackground)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        160
    }
}


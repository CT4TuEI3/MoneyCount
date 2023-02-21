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
    private let titleExpenseEmptyProperty: String
    private let amountExpenseEmptyProperty: Double
    private let dateExpenseEmptyProperty: String
    private let namesEmptyProperty: [NameBalanceModel]
    
    
    // MARK: - UI Elements
    
    private let customHeader = UIView()
    private let namesTableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life cycle
    
    init(title: String, amountExp: Double, date: String, name: [NameBalanceModel]) {
        self.titleExpenseEmptyProperty = title
        self.amountExpenseEmptyProperty = amountExp
        self.dateExpenseEmptyProperty = date
        self.namesEmptyProperty = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        namesEmptyProperty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: namesTVCellIdentifire,
                                                 for: indexPath) as? CardExpenseCell
        cell?.configure(name: namesEmptyProperty[indexPath.row].name, amount: amountExpenseEmptyProperty)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        CustomHeader(color: .systemBackground, title: titleExpenseEmptyProperty,
                     amount: amountExpenseEmptyProperty,
                     paidName: namesEmptyProperty.first ?? NameBalanceModel(name: "", balance: 0.0),
                     date: dateExpenseEmptyProperty)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        160
    }
}


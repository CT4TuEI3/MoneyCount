//
//  CardExpense.swift
//  MoneyCount
//
//  Created by Алексей on 6.02.2023.
//

import UIKit

final class CardExpenceVC: UIViewController {
    
    // MARK: - Private propertyes
    
    private let namesTVCellIdentifire = "namesTVCellIdentifire"
    private let titleExpenceUpdated: String
    private let amountExpenseUpdated: Double
    private let dateExpenseUpdated: String
    private let namesInExpenceUpdated: [NameBalanceModel]
    
    
    // MARK: - UI Elements
    
    private let customHeader = UIView()
    private let namesTableView = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Life cycle
    
    init(title: String, amountExp: Double, date: String, name: [NameBalanceModel]) {
        self.titleExpenceUpdated = title
        self.amountExpenseUpdated = amountExp
        self.dateExpenseUpdated = date
        self.namesInExpenceUpdated = name
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


// MARK: - UITableViewDelegate, UITableViewDataSource

extension CardExpenceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesInExpenceUpdated.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: namesTVCellIdentifire,
                                                 for: indexPath) as? CardExpenseCell
        cell?.configure(name: namesInExpenceUpdated[indexPath.row].name, amount: amountExpenseUpdated)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        CustomHeader(color: .systemBackground, title: titleExpenceUpdated,
                     amount: amountExpenseUpdated,
                     paidName: namesInExpenceUpdated.first ?? NameBalanceModel(name: "", balance: 0.0),
                     date: dateExpenseUpdated)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        160
    }
}


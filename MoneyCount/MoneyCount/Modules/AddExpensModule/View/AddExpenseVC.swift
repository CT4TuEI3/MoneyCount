//
//  AddExpenseVC.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

final class AddExpenseVC: UIViewController {
    
    private let names: [NameBalanceModel]
    
    
    // MARK: - Private properties
    
    private let service = FireBaseService()
    private let titleExpenseIdentifire = "titleExpenseIdentifire"
    private let amountExpenseIdentifire = "amountExpenseIdentifire"
    private let dateExpenseIdentifire = "dateExpenseIdentifire"
    private let paidNameExpenseIdentifire = "paidNameExpenseIdentifire"
    private let sections = AddExpenseSectionType.allCases
    private var titleExpences = ""
    private var amountExpense = 0.0
    private var dateExpense = ""
    private var paidNameExpanse: [NameBalanceModel] = []
    private var currentMoneyCount: MoneyCountModel?
    
    // MARK: - UI Elements
    
    private let addExpenseTable = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Lifecycle
    
    init(names: [NameBalanceModel]) {
        self.names = names
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Add expense"
        view.backgroundColor = .systemBackground
        view.addSubview(addExpenseTable)
        settingsNavigationBar()
        settingsTableView()
        setConstraints()
    }
    
    private func settingsNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedAddExpenceBtn))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func settingsTableView() {
        addExpenseTable.delegate = self
        addExpenseTable.dataSource = self
        addExpenseTable.keyboardDismissMode = .onDrag
        addExpenseTable.register(TitleExpenseCell.self, forCellReuseIdentifier: titleExpenseIdentifire)
        addExpenseTable.register(AmountExpenseCell.self, forCellReuseIdentifier: amountExpenseIdentifire)
        addExpenseTable.register(DateExpenseCell.self, forCellReuseIdentifier: dateExpenseIdentifire)
        addExpenseTable.register(NamePaidCell.self, forCellReuseIdentifier: paidNameExpenseIdentifire)
    }
    
    private func getData() {
        service.getData { [weak self] result in
            switch result {
                case .success(let data):
                    self?.currentMoneyCount = data
                case .failure(let error):
                    self?.showErrorAlert(error: error)
            }
        }
    }
    
    private func sendData() {
        guard var updatedMoneyCountModdel = currentMoneyCount else { return }
        updatedMoneyCountModdel.expence.insert(ExpenceModel(title: titleExpences,
                                                            amount: amountExpense,
                                                            date: dateExpense,
                                                            names: updatedMoneyCountModdel.names), at: 0)
        service.saveData(moneyCount: updatedMoneyCountModdel) { [weak self] error in
            self?.showErrorAlert(error: error)
        }
    }
    
    private func isCompletedValues(_ amountExpense: Double, _ titleExpences: String) -> Bool {
        amountExpense != 0.0 && !titleExpences.isEmpty ? true : false
    }
    
    private func setConstraints() {
        addExpenseTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addExpenseTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addExpenseTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addExpenseTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addExpenseTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: - Actions
    
    @objc
    private func pressedAddExpenceBtn() {
        sendData()
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension AddExpenseVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
            case .title, .amount, .date:
                return 1
                
            case .name:
                return names.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForSection = sections[indexPath.section]
        switch cellForSection {
            case .title:
                let cell = addExpenseTable.dequeueReusableCell(withIdentifier: titleExpenseIdentifire,
                                                               for: indexPath) as? TitleExpenseCell
                cell?.delegate = self
                cell?.configure(placeholder: "Title")
                return cell ?? UITableViewCell()
            case .amount:
                let cell = addExpenseTable.dequeueReusableCell(withIdentifier: amountExpenseIdentifire,
                                                               for: indexPath) as? AmountExpenseCell
                cell?.configure(placeholder: "Amount")
                cell?.delegate = self
                return cell ?? UITableViewCell()
                
            case .date:
                let cell = addExpenseTable.dequeueReusableCell(withIdentifier: dateExpenseIdentifire,
                                                               for: indexPath) as? DateExpenseCell
                cell?.delegate = self
                return cell ?? UITableViewCell()
                
            case .name:
                let cell = addExpenseTable.dequeueReusableCell(withIdentifier: paidNameExpenseIdentifire,
                                                               for: indexPath) as? NamePaidCell
                cell?.configure(textLabel: names[indexPath.row].name)
                return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellForSection = sections[indexPath.section]
        if cellForSection == .name {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemGray6
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}


// MARK: - TitleExpenseCellDelegate

extension AddExpenseVC: TitleExpenseCellDelegate {
    func titleExpenseCell(title: String) {
        titleExpences = title
        navigationItem.rightBarButtonItem?.isEnabled = isCompletedValues(amountExpense, titleExpences)
    }
}


// MARK: - AmountExpenseCellDelegate

extension AddExpenseVC: AmountExpenseCellDelegate {
    func amountExpense(amount: Double) {
        amountExpense = amount
        navigationItem.rightBarButtonItem?.isEnabled = isCompletedValues(amountExpense, titleExpences)
    }
    
    func pressedCurrencyBtn() {
        navigationController?.pushViewController(SelectCurrencyViewController(), animated: true)
    }
    
}


// MARK: - DateExpenseCellDelegate

extension AddExpenseVC: DateExpenseCellDelegate {
    func dateExpense(date: String) {
        dateExpense = date
    }
}


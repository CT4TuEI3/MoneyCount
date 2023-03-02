//
//  AddExpenseVC.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

protocol AddExpenseVCDDelegate: AnyObject {
    func updatedExpenses()
}

final class AddExpenseVC: UIViewController {
    
    // MARK: - Internal propertyes
    
    weak var delegate: AddExpenseVCDDelegate?
    
    
    // MARK: - Private properties
    
    private let service = FireBaseService()
    private let titleExpenseIdentifire = "titleExpenseIdentifire"
    private let amountExpenseIdentifire = "amountExpenseIdentifire"
    private let dateExpenseIdentifire = "dateExpenseIdentifire"
    private let paidNameExpenseIdentifire = "paidNameExpenseIdentifire"
    private let sections = AddExpenseSectionType.allCases
    private let titleMoneyCountForDoc: String
    private var titleExpences = ""
    private var amountExpense = 0.0
    private var dateExpense = ""
    private var paidNameExpanse: [NameBalanceModel] = []
    private var currentMoneyCount: MoneyCountModel?
    private let names: [NameBalanceModel]
    private var currency: String
    private var selectedUsersExpense: [UsersInExpenses] = []
    
    
    // MARK: - UI Elements
    
    private let addExpenseTable = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Lifecycle
    
    init(names: [NameBalanceModel], currency: String, titleMoneyCount: String) {
        self.names = names
        self.currency = currency
        self.titleMoneyCountForDoc = titleMoneyCount
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
        checkStateExpence()
    }
    
    private func settingsNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedAddExpenceBtn))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func checkStateExpence() {
        names.forEach {
            selectedUsersExpense.append(UsersInExpenses(name: $0.name,
                                                        balance: $0.balance,
                                                        state: true))
        }
    }
    
    private func calculateBalance() {
        for i in 0..<selectedUsersExpense.count {
            selectedUsersExpense[i].balance = setAmmount(forName: i)
        }
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
        service.getData(docTitle: titleMoneyCountForDoc) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.currentMoneyCount = data
                case .failure(let error):
                    self?.showErrorAlert(error: error)
            }
        }
    }
    
    private func sendData() {
        var updateNames: [NameBalanceModel] = []
        for i in 0..<selectedUsersExpense.count {
            calculateBalance()
            updateNames.append(NameBalanceModel(name: selectedUsersExpense[i].name,
                                                balance: selectedUsersExpense[i].balance))
        }
        guard var updatedMoneyCountModdel = currentMoneyCount else { return }
        updatedMoneyCountModdel.expence.insert(ExpenceModel(title: titleExpences,
                                                            amount: amountExpense,
                                                            date: dateExpense,
                                                            names: updateNames), at: 0)
        service.saveData(moneyCount: updatedMoneyCountModdel,
                         docTitle: titleMoneyCountForDoc) { [weak self] error in
            self?.showErrorAlert(error: error)
        }
    }
    
    private func isCompletedValues(_ amountExpense: Double, _ titleExpences: String) -> Bool {
        amountExpense != 0.0 && !titleExpences.isEmpty ? true : false
    }
    
    private func updateStatusUsersExpense() {
        addExpenseTable.reloadSections(IndexSet(integer: AddExpenseSectionType.name.rawValue),
                                       with: .automatic)
    }
    
    private func setAmmount(forName: Int) -> Double {
        var result = 0.0
        var selectedCount = 0
        
        if !selectedUsersExpense[forName].state {
            return 0.0
        }
        
        for i in 0..<selectedUsersExpense.count {
            if !selectedUsersExpense[i].state {
                result = 0.0
            } else {
                selectedCount += 1
            }
            
        }
        result = amountExpense / Double(selectedCount)
        result = (round(result * 100) / 100.0)
        return result
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
        delegate?.updatedExpenses()
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
                return selectedUsersExpense.count
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
                cell?.configure(placeholder: "Amount", shortName: currency)
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
                cell?.accessoryType = selectedUsersExpense[indexPath.row].state ? .checkmark : .none
                cell?.configure(textLabel: selectedUsersExpense[indexPath.row].name,
                                amountLabel: setAmmount(forName: indexPath.row))
                return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellForSection = sections[indexPath.section]
        if cellForSection == .name {
            if selectedUsersExpense[indexPath.row].state {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                selectedUsersExpense[indexPath.row].state = false
            } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                selectedUsersExpense[indexPath.row].state = true
            }
            updateStatusUsersExpense()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != AddExpenseSectionType.name.rawValue {
            let header = UIView()
            header.backgroundColor = .systemGray6
            return header
        } else {
            let headerView = CustomSettingsHeadder(forSection: section, color: .red)
            headerView.delegate = self
            return headerView
        }
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
        calculateBalance()
        for i in 0..<selectedUsersExpense.count {
            if selectedUsersExpense[i].state {
                addExpenseTable.reloadRows(at: [IndexPath(row: i,
                                                          section: AddExpenseSectionType.name.rawValue)],
                                           with: .automatic)
            }
        }
        navigationItem.rightBarButtonItem?.isEnabled = isCompletedValues(amountExpense, titleExpences)
    }
    
    func pressedCurrencyBtn() {
        let vc = SelectCurrencyViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - DateExpenseCellDelegate

extension AddExpenseVC: DateExpenseCellDelegate {
    func dateExpense(date: String) {
        dateExpense = date
    }
}


// MARK: - SelectCurrencyViewControllerDelegate

extension AddExpenseVC: SelectCurrencyViewControllerDelegate {
    func selectedCurrency(_ curency: CurrencyModel) {
        currency = curency.shortName
        addExpenseTable.reloadData()
    }
}


// MARK: - CustomSettingsHeadderDelegate

extension AddExpenseVC: CustomSettingsHeadderDelegate {
    func isAllSelected(forSection: Int) {
        
    }
}

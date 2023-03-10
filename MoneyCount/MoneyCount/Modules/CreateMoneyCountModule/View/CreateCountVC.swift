//
//  CreateCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

protocol CreateCountVCDelegate: AnyObject {
    func updatedExpenses()
}

final class CreateCountVC: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: CreateCountVCDelegate?
    
    
    // MARK: - Private properties
    
    private let service = FireBaseService()
    private let textFieldCellIdentifire = "textFieldCellIdentifire"
    private let selectCurrencyCellIdentifier = "selectCurrencyCellIdentifier"
    private let addNamesIdentifier = "addNamesIdentifier"
    private let nameLabelCellIdentifier = "nameLabelCellIdentifier"
    private let sections = SectionType.allCases
    private var namesUsersOneMoneyCount: [NameBalanceModel] = []
    private var titleMoneyCount = ""
    private var discriptionMoneyCount = ""
    private var shortNameCurrency = ""
    
    
    // MARK: - UI Elements
    
    private let table = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Create MoneyCount"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(pressedDoneButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
        view.addSubview(table)
        settingsTableView()
        setConstraints()
    }
    
    private func settingsTableView() {
        table.keyboardDismissMode = .onDrag
        table.backgroundColor = .systemGray6
        table.delegate = self
        table.dataSource = self
        table.register(TextFieldCell.self, forCellReuseIdentifier: textFieldCellIdentifire)
        table.register(SelectCurrencyCell.self, forCellReuseIdentifier: selectCurrencyCellIdentifier)
        table.register(AddNamesCell.self, forCellReuseIdentifier: addNamesIdentifier)
        table.register(NamesCell.self, forCellReuseIdentifier: nameLabelCellIdentifier)
    }
    
    private func setConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func sendData() {
        service.saveData(moneyCount: MoneyCountModel(title: titleMoneyCount,
                                                     description: discriptionMoneyCount,
                                                     names: namesUsersOneMoneyCount,
                                                     currency: shortNameCurrency,
                                                     expence: []), docTitle: titleMoneyCount, { [weak self] error in
            self?.showErrorAlert(error: error)
        })
    }
    
    
    // MARK: - Actions
    
    @objc
    private func pressedDoneButton() {
        sendData()
        delegate?.updatedExpenses()
        navigationController?.pushViewController(MainMoneyCountVC(names: namesUsersOneMoneyCount,
                                                                  titleMoneyCount: titleMoneyCount, currency: shortNameCurrency),
                                                 animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension CreateCountVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
            case .title:
                return 2
            case .currency:
                return 1
            case .names:
                return namesUsersOneMoneyCount.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForSection = sections[indexPath.section]
        switch cellForSection {
            case .title:
                let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifire,
                                                         for: indexPath) as? TextFieldCell
                cell?.configure(placeholder: indexPath.row == 0 ? "Title" : "Discription")
                cell?.delegate = self
                return cell ?? UITableViewCell()
                
            case .currency:
                let cell = tableView.dequeueReusableCell(withIdentifier: selectCurrencyCellIdentifier,
                                                         for: indexPath) as? SelectCurrencyCell
                cell?.configure(shortName: shortNameCurrency)
                return cell ?? UITableViewCell()
                
            case .names:
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: addNamesIdentifier,
                                                             for: indexPath) as? AddNamesCell
                    cell?.configure(placeholder: "Name")
                    cell?.delegate = self
                    return cell ?? UITableViewCell()
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: nameLabelCellIdentifier,
                                                             for: indexPath) as? NamesCell
                    cell?.configure(textLabel: namesUsersOneMoneyCount[indexPath.row - 1].name)
                    return cell ?? UITableViewCell()
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SectionType.currency.rawValue {
            let vc = SelectCurrencyViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard indexPath.section == 2, indexPath.row != 0 else { return .none }
        return .delete
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            namesUsersOneMoneyCount.remove(at: indexPath.row - 1)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            if !titleMoneyCount.isEmpty && !namesUsersOneMoneyCount.isEmpty {
                navigationItem.rightBarButtonItem?.isEnabled = true
            } else {
                navigationItem.rightBarButtonItem?.isEnabled = false
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


// MARK: - AddNamesCellDelegate

extension CreateCountVC: AddNamesCellDelegate {
    func pressedAddNamesButton(name: String) {
        namesUsersOneMoneyCount.append(NameBalanceModel(name: name, balance: 0.0))
        table.beginUpdates()
        table.insertRows(at: [IndexPath(row: namesUsersOneMoneyCount.count,
                                        section: SectionType.names.rawValue)],
                         with: .top)
        table.endUpdates()
        if !titleMoneyCount.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}


// MARK: - TextFieldCellDelegate

extension CreateCountVC: TextFieldCellDelegate {
    func pressedDoneBtn(title: String, text: String) {
        if title == "Title" {
            titleMoneyCount = text
        } else {
            discriptionMoneyCount = text
        }
        if titleMoneyCount.count != 0 && namesUsersOneMoneyCount.count != 0 {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}


// MARK: - SelectCurrencyViewControllerDelegate

extension CreateCountVC: SelectCurrencyViewControllerDelegate {
    func selectedCurrency(_ curency: CurrencyModel) {
        shortNameCurrency = curency.shortName
        table.reloadData()
    }
}

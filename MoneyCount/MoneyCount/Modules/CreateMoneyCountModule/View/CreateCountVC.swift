//
//  CreateCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

final class CreateCountVC: UIViewController {
    
    //MARK: - Private properties
    
    private let textFieldCellIdentifire = "textFieldCellIdentifire"
    private let selectCurrencyCellIdentifier = "selectCurrencyCellIdentifier"
    private let addNamesIdentifier = "addNamesIdentifier"
    private let sections = SectionType.allCases
    
    
    // MARK: - UI Elements
    
    private let table = UITableView(frame: .zero, style: .grouped)
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "Create MoneyCount"
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        settingsTableView()
        setConstraints()
    }
    
    private func settingsTableView() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemGray5
        table.delegate = self
        table.dataSource = self
        table.register(TextFieldCell.self, forCellReuseIdentifier: textFieldCellIdentifire)
        table.register(SelectCurrencyCell.self, forCellReuseIdentifier: selectCurrencyCellIdentifier)
        table.register(AddNamesCell.self, forCellReuseIdentifier: addNamesIdentifier)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension CreateCountVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == SectionType.title.rawValue ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifire,
                                                 for: indexPath) as? TextFieldCell
        if indexPath.section == SectionType.title.rawValue {
            cell?.configure(placeholder: indexPath.row == 0 ? "Title" : "Discription")
            return cell ?? UITableViewCell()
        } else if indexPath.section == SectionType.currency.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: selectCurrencyCellIdentifier,
                                                     for: indexPath) as? SelectCurrencyCell
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addNamesIdentifier,
                                                     for: indexPath) as? AddNamesCell
            cell?.configure(placeholder: "Name")
            cell?.delegate = self
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SectionType.currency.rawValue {
            navigationController?.pushViewController(SelectCurrencyViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .systemGray4
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

extension CreateCountVC: AddNamesCellDelegate {
    func pressedAddNamesButton() {
    }
}

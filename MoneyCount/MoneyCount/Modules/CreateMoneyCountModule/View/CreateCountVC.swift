//
//  v2CreateCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

final class CreateCountVC: UIViewController {
    
    //MARK: - Private properties
    
    private let textFieldCellIdentifire = "textFieldCellIdentifire"
    private let selectCurrencyCellIdentifier = "selectCurrencyCellIdentifier"
    private let sections = SectionType.allCases
    
    
    // MARK: - UI Elements
    
    private let table = UITableView(frame: .zero, style: .plain)
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(table)
        settingsTableView()
        setConstraints()
    }
    
    private func settingsTableView() {
        title = "Create MoneyCount"
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .systemBackground
        table.register(TextFieldCell.self, forCellReuseIdentifier: textFieldCellIdentifire)
        table.register(SelectCurrencyCell.self, forCellReuseIdentifier: selectCurrencyCellIdentifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifire, for: indexPath) as? TextFieldCell
        if indexPath.section == SectionType.title.rawValue {
            cell?.configureV2(placeholder: indexPath.row == 0 ? "Title" : "Discription")
            return cell ?? UITableViewCell()
        } else if indexPath.section == SectionType.currency.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: selectCurrencyCellIdentifier, for: indexPath) as? SelectCurrencyCell
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        } else {
            cell?.configureV2(placeholder: "Name")
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            navigationController?.pushViewController(SelectCurrencyViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .systemGray5
        return footer
    }
}

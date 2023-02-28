//
//  ExpensesVC.swift
//  MoneyCount
//
//  Created by Алексей on 30.01.2023.
//

import UIKit

protocol ExpensesVCDelegate: AnyObject {
    func updatedNavBarBtn()
    func isNeedUpdateddData(_ completion: @escaping (Bool) -> Void)
}

final class ExpensesVC: UIViewController {
    
    // MARK: - Internal propertyes
    
    weak var delegate: ExpensesVCDelegate?
    
    
    // MARK: - Private propertyes
    
    private let firebaseService = FireBaseService()
    private let expensesIdentifire = "expensesIdentifire"
    private var moneyCount: MoneyCountModel?
    private var titleDocumentDdataBase: String = ""
    
    
    // MARK: - UI Elements
    
    private let expensesTableView = UITableView()
    private let expensesSearchBar = UISearchBar()
    private let updateDataActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    
    // MARK: - Life cycle
    
    init(docTitle: String) {
        self.titleDocumentDdataBase = docTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseService.getData(docTitle: titleDocumentDdataBase) { [weak self] result in
            switch result {
                case .success(let success):
                    self?.moneyCount = success
                    self?.expensesTableView.reloadData()
                    
                case .failure(let failure):
                    self?.showErrorAlert(error: failure)
            }
        }
        setupUI()
        searchBarSettings()
        settingsTableView()
        setConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.updatedNavBarBtn()
        delegate?.isNeedUpdateddData({ [weak self] isNeedUpddated in
            guard let self = self else { return }
            if isNeedUpddated {
                self.updateDataActivityIndicator.startAnimating()
                self.firebaseService.getData(docTitle: self.titleDocumentDdataBase) { [weak self] result in
                    self?.updateDataActivityIndicator.stopAnimating()
                    switch result {
                        case .success(let success):
                            self?.moneyCount = success
                            self?.expensesTableView.reloadData()
                            
                        case .failure(let failure):
                            self?.showErrorAlert(error: failure)
                    }
                }
                self.expensesTableView.reloadData()
            }
        })
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(updateDataActivityIndicator)
        view.addSubview(expensesTableView)
        view.addSubview(expensesSearchBar)
    }
    
    private func settingsTableView() {
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        expensesTableView.keyboardDismissMode = .onDrag
        expensesTableView.backgroundColor = .systemGray6
        expensesTableView.register(ExpensesCell.self, forCellReuseIdentifier: expensesIdentifire)
    }
    
    private func searchBarSettings() {
        expensesSearchBar.delegate = self
    }
    
    private func setConstrains() {
        expensesTableView.translatesAutoresizingMaskIntoConstraints = false
        expensesSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expensesSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            expensesSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expensesSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            expensesTableView.topAnchor.constraint(equalTo: expensesSearchBar.bottomAnchor),
            expensesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expensesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            expensesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: UISearchBarDelegate

extension ExpensesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}


// MARK: UITableViewDelegate, UITableViewDataSource

extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moneyCount?.expence.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let expence = moneyCount?.expence[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: expensesIdentifire,
                                                 for: indexPath) as? ExpensesCell
        cell?.configure(expence: expence,
                        name: expence.names.first ?? NameBalanceModel(name: "n/a", balance: 0.0))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = moneyCount else { return }
        navigationController?.pushViewController(CardExpenceVC(title: model.expence[indexPath.row].title,
                                                               amountExp: model.expence[indexPath.row].amount,
                                                               date: model.expence[indexPath.row].date,
                                                               name: model.names ),
                                                 animated: true)
    }
}

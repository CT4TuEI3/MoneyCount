//
//  SelectCurrencyViewController.swift
//  MoneyCount
//
//  Created by Алексей on 21.01.2023.
//

import UIKit

protocol SelectCurrencyViewControllerDelegate: AnyObject {
    func selectedCurrency(_ curency: CurrencyModel)
}

final class SelectCurrencyViewController: UIViewController {
    
    weak var delegate: SelectCurrencyViewControllerDelegate?
    
    
    //MARK: - Private properties
    
    private let currencyCellIdentifier = "currencyCell"
    private let currencyArray = [CurrencyModel(shortName: "RUB", fullName: "Russian ruble"),
                                 CurrencyModel(shortName: "USD", fullName: "US Dollar"),
                                 CurrencyModel(shortName: "EUR", fullName: "Euro")]
    
    
    //MARK: - UI elements
    
    private let currencyTableView = UITableView()
    private let searchBarCurrency = UISearchBar()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBarCurrency)
        view.addSubview(currencyTableView)
        settingsSearchbar()
        settingsCurrencyTableView()
        setConstraints()
    }
    
    private func settingsSearchbar() {
        searchBarCurrency.translatesAutoresizingMaskIntoConstraints = false
        searchBarCurrency.delegate = self
    }
    
    private func settingsCurrencyTableView() {
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        currencyTableView.register(CustomCurrencyCell.self, forCellReuseIdentifier: currencyCellIdentifier)
        currencyTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBarCurrency.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarCurrency.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarCurrency.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            currencyTableView.topAnchor.constraint(equalTo: searchBarCurrency.bottomAnchor),
            currencyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - UISearchBarDelegate

extension SelectCurrencyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellIdentifier,
                                                 for: indexPath) as? CustomCurrencyCell
        cell?.configure(shortName: currencyArray[indexPath.row].shortName,
                        fullName: currencyArray[indexPath.row].fullName)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedCurrency(currencyArray[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

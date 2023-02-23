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
    
    
    // MARK: - Private properties
    
    private let currencyCellIdentifier = "currencyCell"
    private let currencyArray = [CurrencyModel(shortName: "AED", fullName: "United Arab Emirates Dirham"),
                                 CurrencyModel(shortName: "ARS", fullName: "Argentine Peso"),
                                 CurrencyModel(shortName: "AUD", fullName: "Australian Dollar"),
                                 CurrencyModel(shortName: "BYN", fullName: "Belarussian Ruble"),
                                 CurrencyModel(shortName: "CAD", fullName: "Canadian Dollar"),
                                 CurrencyModel(shortName: "CHF", fullName: "Swiss Franc"),
                                 CurrencyModel(shortName: "CZK", fullName: "Czech Koruna"),
                                 CurrencyModel(shortName: "HKD", fullName: "Hong Kong Dollar"),
                                 CurrencyModel(shortName: "IQD", fullName: "Iraqi Dinar"),
                                 CurrencyModel(shortName: "JPY", fullName: "Japanese Yen"),
                                 CurrencyModel(shortName: "LKR", fullName: "Sri Lankan Rupee"),
                                 CurrencyModel(shortName: "SEK", fullName: "Swedish Krona"),
                                 CurrencyModel(shortName: "SGD", fullName: "Singapore Dollar"),
                                 CurrencyModel(shortName: "RUB", fullName: "Russian ruble"),
                                 CurrencyModel(shortName: "USD", fullName: "US Dollar"),
                                 CurrencyModel(shortName: "EUR", fullName: "Euro"),
                                 CurrencyModel(shortName: "GBR", fullName: "British pounds"),
                                 CurrencyModel(shortName: "TRY", fullName: "Turkish Lira")]
    private var filtredData: [CurrencyModel] = []
    
    
    // MARK: - UI elements
    
    private let currencyTableView = UITableView()
    private let searchBarCurrency = UISearchBar()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBarCurrency)
        view.addSubview(currencyTableView)
        settingsSearchbar()
        settingsCurrencyTableView()
        setConstraints()
    }
    
    private func settingsSearchbar() {
        filtredData = currencyArray
        searchBarCurrency.delegate = self
    }
    
    private func settingsCurrencyTableView() {
        currencyTableView.dataSource = self
        currencyTableView.delegate = self
        currencyTableView.register(CustomCurrencyCell.self, forCellReuseIdentifier: currencyCellIdentifier)
    }
    
    private func setConstraints() {
        searchBarCurrency.translatesAutoresizingMaskIntoConstraints = false
        currencyTableView.translatesAutoresizingMaskIntoConstraints = false
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


// MARK: - UITableViewDelegate, UITableViewDataSource

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellIdentifier,
                                                 for: indexPath) as? CustomCurrencyCell
        cell?.configure(shortName: filtredData[indexPath.row].shortName,
                        fullName: filtredData[indexPath.row].fullName)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedCurrency(filtredData[indexPath.row])

        navigationController?.popViewController(animated: true)
    }
}


// MARK: - UISearchBarDelegate

extension SelectCurrencyViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredData = []
        
        if searchText == "" {
            filtredData = currencyArray
        }
        
        for word in currencyArray {
            if word.fullName.lowercased().contains(searchText.lowercased()) ||
                word.shortName.lowercased().contains(searchText.lowercased()) {
                filtredData.append(word)
            }
        }
        self.currencyTableView.reloadData()
    }
}

//
//  CreateCountViewController.swift
//  MoneyCount
//
//  Created by Алексей on 20.01.2023.
//

import UIKit

final class CreateCountViewController: UIViewController {
    
    //MARK: - UI Elements
    
    let titleMCTextField = UITextField()
    let discriptionMCTextField = UITextField()
    let currencyContainer = UIView()
    let currencyLabel = UILabel()
    let currencyValueLabel = UILabel()
    let currencyImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    let selectCurrencyButton = UIButton()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleMCTextField)
        view.addSubview(discriptionMCTextField)
        view.addSubview(currencyContainer)
        
        currencyContainer.addSubview(currencyLabel)
        currencyContainer.addSubview(currencyValueLabel)
        currencyContainer.addSubview(currencyImageView)
        currencyContainer.addSubview(selectCurrencyButton)
        
        settingsTextFields()
        settingsCurrencyContainer()
        settingsCurrencyLabel()
        settingsCurrensyValueLabel()
        settingsCurrencyImage()
        settingSelectCurrencyButton()
        settingsNavigationBar()
        settingsConstraints()
    }
    
    private func settingsTextFields() {
        titleMCTextField.translatesAutoresizingMaskIntoConstraints = false
        titleMCTextField.placeholder = "Title"
        titleMCTextField.borderStyle = .roundedRect
        
        discriptionMCTextField.translatesAutoresizingMaskIntoConstraints = false
        discriptionMCTextField.placeholder = "Description"
        discriptionMCTextField.borderStyle = .roundedRect
    }
    
    private func settingsCurrencyContainer() {
        currencyContainer.translatesAutoresizingMaskIntoConstraints = false
        currencyContainer.layer.borderWidth = 1
        currencyContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        currencyContainer.layer.cornerRadius = 4
    }
    
    private func settingsCurrencyLabel() {
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.text = "Currency:"
    }
    
    private func settingsCurrensyValueLabel() {
        currencyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyValueLabel.text = "Rub"
    }
    
    private func settingsCurrencyImage() {
        currencyImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func settingSelectCurrencyButton() {
        selectCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        selectCurrencyButton.addTarget(self, action: #selector(pressedCurrencyButton), for: .touchUpInside)
        
    }
    
    private func settingsNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    
    //MARK: - Actions
    
    @objc
    private func pressedCurrencyButton() {
        navigationController?.pushViewController(SelectCurrencyViewController(), animated: true)
    }
}


//MARK: - Set constraints

private extension CreateCountViewController {
    func settingsConstraints() {
        NSLayoutConstraint.activate([
            titleMCTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleMCTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleMCTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleMCTextField.heightAnchor.constraint(equalToConstant: 48),
            
            discriptionMCTextField.topAnchor.constraint(equalTo: titleMCTextField.bottomAnchor, constant: 16),
            discriptionMCTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            discriptionMCTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            discriptionMCTextField.heightAnchor.constraint(equalToConstant: 48),
            
            currencyContainer.topAnchor.constraint(equalTo: discriptionMCTextField.bottomAnchor, constant: 16),
            currencyContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currencyContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            currencyContainer.heightAnchor.constraint(equalToConstant: 48),
            
            currencyLabel.centerYAnchor.constraint(equalTo: currencyContainer.centerYAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: currencyContainer.leadingAnchor, constant: 8),
            
            currencyValueLabel.centerYAnchor.constraint(equalTo: currencyContainer.centerYAnchor),
            currencyValueLabel.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 8),
            
            currencyImageView.centerYAnchor.constraint(equalTo: currencyContainer.centerYAnchor),
            currencyImageView.trailingAnchor.constraint(equalTo: currencyContainer.trailingAnchor, constant: -24),
            currencyImageView.widthAnchor.constraint(equalToConstant: 8),
            currencyImageView.heightAnchor.constraint(equalToConstant: 16),
            
            selectCurrencyButton.topAnchor.constraint(equalTo: currencyContainer.topAnchor),
            selectCurrencyButton.leadingAnchor.constraint(equalTo: currencyContainer.leadingAnchor),
            selectCurrencyButton.trailingAnchor.constraint(equalTo: currencyContainer.trailingAnchor),
            selectCurrencyButton.bottomAnchor.constraint(equalTo: currencyContainer.bottomAnchor),
        ])
    }
}

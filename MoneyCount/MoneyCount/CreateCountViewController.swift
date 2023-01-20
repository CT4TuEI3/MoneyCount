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
        settingsTextFields()
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
    
    private func settingsNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }
    
    private func settingsConstraints() {
        NSLayoutConstraint.activate([
            titleMCTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleMCTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleMCTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleMCTextField.heightAnchor.constraint(equalToConstant: 48),
            
            discriptionMCTextField.topAnchor.constraint(equalTo: titleMCTextField.bottomAnchor, constant: 16),
            discriptionMCTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            discriptionMCTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            discriptionMCTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

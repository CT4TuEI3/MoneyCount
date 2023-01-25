//
//  InputCell.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private let titleMCTextField = UITextField()
    
    
    //MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure
    
    func configure(placeholder: String) {
        titleMCTextField.placeholder = placeholder
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(titleMCTextField)
        settingsTextFields()
        setConstraints()
    }
    
    private func settingsTextFields(){
        titleMCTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleMCTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleMCTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleMCTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleMCTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

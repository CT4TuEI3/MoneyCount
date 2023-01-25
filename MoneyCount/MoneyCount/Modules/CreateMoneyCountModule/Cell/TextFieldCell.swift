//
//  InputCell.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

final class TextFieldCell: UITableViewCell {
    
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
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(titleMCTextField)
        settingsTextFields()
        setConstraints()
    }
    
    private func settingsTextFields(){
        titleMCTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureV2(placeholder: String) {
        titleMCTextField.placeholder = placeholder
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

//
//  AmountExpenseCell.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

final class AmountExpenseCell: UITableViewCell {
    
    //MARK: UI Elements
    
    private let amountExpenseTF = UITextField()
    
    
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
        amountExpenseTF.placeholder = placeholder
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(amountExpenseTF)
        setConstraints()
    }
    
    private func setConstraints() {
        amountExpenseTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amountExpenseTF.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountExpenseTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            amountExpenseTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            amountExpenseTF.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

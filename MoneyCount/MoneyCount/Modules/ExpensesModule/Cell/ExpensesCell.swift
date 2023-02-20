//
//  ExpensesCell.swift
//  MoneyCount
//
//  Created by Алексей on 30.01.2023.
//

import UIKit

final class ExpensesCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private let titleExpensesLabel = UILabel()
    private let paidNameExpensesLabel = UILabel()
    private let dateExpensesLabel = UILabel()
    private let amountExpensesLabel = UILabel()
    
    
    //MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        settingsLabels()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(expence: ExpenceModel, name: NameBalanceModel) {
        titleExpensesLabel.text = expence.title
        paidNameExpensesLabel.text = name.name
        dateExpensesLabel.text = expence.date
        amountExpensesLabel.text = String(expence.amount)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(titleExpensesLabel)
        addSubview(paidNameExpensesLabel)
        addSubview(dateExpensesLabel)
        addSubview(amountExpensesLabel)
    }
    
    private func settingsLabels() {
        titleExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        paidNameExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        dateExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        amountExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleExpensesLabel.textColor = .tintColor
        
        paidNameExpensesLabel.font = UIFont.systemFont(ofSize: 16)
        paidNameExpensesLabel.textColor = .gray
        
        dateExpensesLabel.font = UIFont.systemFont(ofSize: 16)
        dateExpensesLabel.textColor = .gray
        
        amountExpensesLabel.textColor = .tintColor
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleExpensesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleExpensesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            paidNameExpensesLabel.topAnchor.constraint(equalTo: titleExpensesLabel.bottomAnchor, constant: 8),
            paidNameExpensesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paidNameExpensesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            dateExpensesLabel.topAnchor.constraint(equalTo: amountExpensesLabel.bottomAnchor, constant: 8),
            dateExpensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateExpensesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            amountExpensesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            amountExpensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

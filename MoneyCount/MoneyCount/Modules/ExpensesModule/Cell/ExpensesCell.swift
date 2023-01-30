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
    private let sumExpensesLabel = UILabel()
    
    
    //MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        settingsLabel()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(titleExpensesLabel)
        addSubview(paidNameExpensesLabel)
        addSubview(dateExpensesLabel)
        addSubview(sumExpensesLabel)
    }
    
    private func settingsLabel() {
        titleExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        paidNameExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        dateExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        sumExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleExpensesLabel.text = "Pomelo"
        paidNameExpensesLabel.text = "Valeri"
        dateExpensesLabel.text = "30.01"
        sumExpensesLabel.text = "10 TL"
        
        titleExpensesLabel.textColor = .tintColor
        
        paidNameExpensesLabel.font = UIFont.systemFont(ofSize: 16)
        paidNameExpensesLabel.textColor = .gray
        
        dateExpensesLabel.font = UIFont.systemFont(ofSize: 16)
        dateExpensesLabel.textColor = .gray
        
        sumExpensesLabel.textColor = .tintColor
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleExpensesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleExpensesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            paidNameExpensesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paidNameExpensesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            dateExpensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateExpensesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            sumExpensesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            sumExpensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

//
//  CardExpenseCell.swift
//  MoneyCount
//
//  Created by Алексей on 6.02.2023.
//

import UIKit

final class CardExpenseCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private let namePaidLabel = UILabel()
    private let amountLabel = UILabel()
    
    
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
        addSubview(namePaidLabel)
        addSubview(amountLabel)
        settingsNamePaidLabel()
        settingsAmountLabel()
        setConstraints()
    }
    
    private func settingsNamePaidLabel() {
        namePaidLabel.text = "Steve"
    }
    
    private func settingsAmountLabel() {
        amountLabel.text = "500"
    }
    
    private func setConstraints() {
        namePaidLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namePaidLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            namePaidLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}


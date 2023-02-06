//
//  CustomHeader.swift
//  MoneyCount
//
//  Created by Алексей on 6.02.2023.
//

import UIKit

final class CustomHeader: UIView {

    // MARK: - UI Elements
    
    private let titleExpenseLabel = UILabel()
    private let amountLabel = UILabel()
    private let paidNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let separatorLine = UIImageView()
    
    
    // MARK: - Life cycle

    init(color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(titleExpenseLabel)
        addSubview(amountLabel)
        addSubview(paidNameLabel)
        addSubview(dateLabel)
        addSubview(separatorLine)
        
        settingsLabels()
        setingsSeparatorLine()
        setConstraints()
    }
    
    private func settingsLabels() {
        titleExpenseLabel.text = "Abc"
        amountLabel.text = "500 RUB"
        paidNameLabel.text = "Alex"
        dateLabel.text = "6.2.2023"
    }
    
    private func setingsSeparatorLine() {
        separatorLine.backgroundColor = .systemGray6
    }
    
    private func setConstraints() {
        titleExpenseLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        paidNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleExpenseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleExpenseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountLabel.topAnchor.constraint(equalTo: titleExpenseLabel.bottomAnchor, constant: 8),
            
            paidNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paidNameLabel.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: -16),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: paidNameLabel.centerYAnchor),

            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}


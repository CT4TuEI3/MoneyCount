//
//  CustomCurrencyCell.swift
//  MoneyCount
//
//  Created by Алексей on 22.01.2023.
//

import UIKit

final class CustomCurrencyCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let currencyBoldLabel = UILabel()
    private let currencyNormalFullLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(shortName: String, fullName: String) {
        currencyBoldLabel.text = shortName
        currencyNormalFullLabel.text = fullName
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(currencyBoldLabel)
        addSubview(currencyNormalFullLabel)
        settingsCurrencyBoldLabel()
        setConstraints()
    }
    
    private func settingsCurrencyBoldLabel() {
        currencyBoldLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private func setConstraints() {
        currencyNormalFullLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyBoldLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyBoldLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyBoldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            currencyNormalFullLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyNormalFullLabel.leadingAnchor.constraint(equalTo: currencyBoldLabel.trailingAnchor, constant: 8)
        ])
    }
}

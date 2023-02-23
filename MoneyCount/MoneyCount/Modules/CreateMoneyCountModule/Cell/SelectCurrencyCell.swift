//
//  v2Cell.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

final class SelectCurrencyCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let fullNameCurrencylabel = UILabel()
    private let shortNameCurrencyLabel = UILabel()
    private let currencyImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(shortName: String) {
        shortNameCurrencyLabel.text = shortName
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(fullNameCurrencylabel)
        contentView.addSubview(shortNameCurrencyLabel)
        contentView.addSubview(currencyImageView)
        settingsLabels()
        settings()
    }
    
    private func settingsLabels() {
        fullNameCurrencylabel.text = "Currency"
        shortNameCurrencyLabel.text = "USD"
        shortNameCurrencyLabel.textColor = .tintColor
    }
        
    private func settings() {
        fullNameCurrencylabel.translatesAutoresizingMaskIntoConstraints = false
        shortNameCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullNameCurrencylabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            fullNameCurrencylabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            shortNameCurrencyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            shortNameCurrencyLabel.leadingAnchor.constraint(equalTo: fullNameCurrencylabel.trailingAnchor, constant: 16),
            
            currencyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            currencyImageView.widthAnchor.constraint(equalToConstant: 8),
            currencyImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

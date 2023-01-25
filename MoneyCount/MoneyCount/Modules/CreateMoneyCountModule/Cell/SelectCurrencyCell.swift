//
//  v2Cell.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

final class SelectCurrencyCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private let normalLabel = UILabel()
    private let tintLabel = UILabel()
    private let currencyImageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
    
    
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
        contentView.addSubview(normalLabel)
        contentView.addSubview(tintLabel)
        contentView.addSubview(currencyImageView)
        settingsLabels()
        settings()
    }
    
    private func settingsLabels() {
        normalLabel.text = "Currency"
        tintLabel.text = "USD"
        tintLabel.textColor = .tintColor
    }
    
    private func settings() {
        normalLabel.translatesAutoresizingMaskIntoConstraints = false
        tintLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            normalLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            normalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            tintLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tintLabel.leadingAnchor.constraint(equalTo: normalLabel.trailingAnchor, constant: 16),
            
            currencyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            currencyImageView.widthAnchor.constraint(equalToConstant: 8),
            currencyImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

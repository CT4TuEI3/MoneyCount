//
//  BalacesCell.swift
//  MoneyCount
//
//  Created by Алексей on 1.02.2023.
//

import UIKit

final class BalacesCell: UITableViewCell {
    
    // MARK: - UI Elements

    private let namesLabel = UILabel()
    private let amountLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(names: String) {
        namesLabel.text = names
    }

    
    // MARK: - Private Methods

    private func setupUI() {
        addSubview(namesLabel)
        addSubview(amountLabel)
        settingsConstrains()
    }
        
    private func settingsConstrains() {
        namesLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            namesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

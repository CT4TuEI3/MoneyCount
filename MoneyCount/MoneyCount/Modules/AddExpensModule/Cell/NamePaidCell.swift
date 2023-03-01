//
//  NamePaidCell.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

final class NamePaidCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let namePaidLabel = UILabel()
    private let amountLabelOneName = UILabel()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(textLabel: String, amountLabel: Double) {
        namePaidLabel.text = textLabel
        amountLabelOneName.text = String(format: "%.2f", amountLabel)
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(namePaidLabel)
        addSubview(amountLabelOneName)
        setConstraints()
    }
    
    
    private func setConstraints() {
        namePaidLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabelOneName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namePaidLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            namePaidLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            amountLabelOneName.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabelOneName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64)
        ])
    }
}

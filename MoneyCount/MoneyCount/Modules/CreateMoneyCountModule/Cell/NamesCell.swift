//
//  NamesCell.swift
//  MoneyCount
//
//  Created by Алексей on 25.01.2023.
//

import UIKit

final class NamesCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(textLabel: String) {
        nameLabel.text = textLabel
    }

    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        settings()
        setConstraint()
    }
    
    private func settings() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Alexey"
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    
    
}

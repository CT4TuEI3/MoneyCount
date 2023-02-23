//
//  NamesCell.swift
//  MoneyCount
//
//  Created by Алексей on 25.01.2023.
//

import UIKit

final class NamesCell: UITableViewCell {
    
    // MARK: - Private property
    
    private let nameLabel = UILabel()
    
    
    // MARK: - Life Cycle

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

    
    // MARK: - Private method
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        setConstraint()
    }
    
    private func setConstraint() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}

//
//  CustomMoneyCountCell.swift
//  MoneyCount
//
//  Created by Алексей on 20.01.2023.
//

import UIKit

final class CustomMoneyCountCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    private let nameLabel = UILabel()
    private let secondLabel = UILabel()
    private let cellImage = UIImageView(image: UIImage(systemName: "chevron.forward"))
    
    
    //MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure
    
    func configure(title: String, discription: String) {
        nameLabel.text = title
        secondLabel.text = discription
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(secondLabel)
        addSubview(cellImage)
        settingsLabel()
        secondSettingsLabe()
        setConstraints()
        
    }
    
    private func settingsLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func secondSettingsLabe() {
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.font = UIFont.systemFont(ofSize: 12)
        secondLabel.textColor = .gray
    }
    
    private func setConstraints() {
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            secondLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            secondLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            secondLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            cellImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            cellImage.widthAnchor.constraint(equalToConstant: 8),
            cellImage.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}

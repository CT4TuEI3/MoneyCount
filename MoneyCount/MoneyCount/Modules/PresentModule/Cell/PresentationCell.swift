//
//  PresentationCell.swift
//  MoneyCount
//
//  Created by Алексей on 10.02.2023.
//

import UIKit

final class PresentationCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let mainCellImage = UIImageView()
    private let titleLabel = UILabel()
    private let discriptionLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Configure
    
    func configure(image: String, title: String, discription: String ) {
        mainCellImage.image = UIImage(systemName: image)
        titleLabel.text = title
        discriptionLabel.text = discription
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(mainCellImage)
        addSubview(titleLabel)
        addSubview(discriptionLabel)
        settingsConstraint()
        settingsLabels()
    }
        
    private func settingsLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        discriptionLabel.font = UIFont.systemFont(ofSize: 14)
        discriptionLabel.textColor = .gray
        discriptionLabel.numberOfLines = 0
        discriptionLabel.textAlignment = .left
    }
    
    private func settingsConstraint() {
        mainCellImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainCellImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainCellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainCellImage.heightAnchor.constraint(equalToConstant: 40),
            mainCellImage.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: mainCellImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            discriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            discriptionLabel.leadingAnchor.constraint(equalTo: mainCellImage.trailingAnchor, constant:  10),
            discriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            discriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}


//
//  AddNamesCell.swift
//  MoneyCount
//
//  Created by Алексей on 25.01.2023.
//

import UIKit

protocol AddNamesCellDelegate: AnyObject {
    func pressedAddNamesButton()
}

final class AddNamesCell: UITableViewCell {
    
    weak var delegate: AddNamesCellDelegate?
    
    
    //MARK: - UI Elements
    
    private let addNameTextField = UITextField()
    private let addNameButton = UIButton()
    
    
    //MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure
    
    func configure(placeholder: String) {
        addNameTextField.placeholder = placeholder
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(addNameTextField)
        contentView.addSubview(addNameButton)
        settings()
        setConstraints()
    }
    
    private func settings() {
        addNameTextField.translatesAutoresizingMaskIntoConstraints = false
        addNameButton.translatesAutoresizingMaskIntoConstraints = false
        addNameButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addNameButton.addTarget(self, action: #selector(didPressedBtn), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            addNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            addNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addNameButton.topAnchor.constraint(equalTo: topAnchor),
            addNameButton.leadingAnchor.constraint(equalTo: addNameTextField.trailingAnchor, constant: 8),
            addNameButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            addNameButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func didPressedBtn() {
        delegate?.pressedAddNamesButton()
    }
}

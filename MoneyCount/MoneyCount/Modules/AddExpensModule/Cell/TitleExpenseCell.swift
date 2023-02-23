//
//  TitleExpenseCell.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

protocol TitleExpenseCellDelegate: AnyObject {
    func titleExpenseCell(title: String)
}

final class TitleExpenseCell: UITableViewCell {
    
    // MARK: - Properties

    weak var delegate: TitleExpenseCellDelegate?
    
    
    // MARK: - UI Elements
    
    private let titleExpenseTF = UITextField()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(placeholder: String) {
        titleExpenseTF.placeholder = placeholder
        titleExpenseTF.delegate = self
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(titleExpenseTF)
        setConstraints()
    }
    
    private func setConstraints() {
        titleExpenseTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleExpenseTF.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleExpenseTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleExpenseTF.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleExpenseTF.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}


// MARK: - UITextFieldDelegate

extension TitleExpenseCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.titleExpenseCell(title: text)
    }
}

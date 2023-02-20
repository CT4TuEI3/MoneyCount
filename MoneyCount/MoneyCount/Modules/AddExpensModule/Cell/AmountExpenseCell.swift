//
//  AmountExpenseCell.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

protocol AmountExpenseCellDelegate: AnyObject {
    func pressedCurrencyBtn()
    func amountExpense(amount: Double)
}

final class AmountExpenseCell: UITableViewCell {
    
    weak var delegate: AmountExpenseCellDelegate?
    
    //MARK: UI Elements
    
    private let amountExpenseTF = UITextField()
    private let currencyAmountBtn = UIButton()
    private let currencyShortLabel = UILabel()
    
    
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
        amountExpenseTF.placeholder = placeholder
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(amountExpenseTF)
        contentView.addSubview(currencyAmountBtn)
        addSubview(currencyShortLabel)
        settingsUIElements()
        setConstraints()
    }
    
    private func settingsUIElements() {
        amountExpenseTF.keyboardType = .decimalPad
        amountExpenseTF.delegate = self
        currencyShortLabel.text = "RUB"
        currencyAmountBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        currencyAmountBtn.addTarget(self, action: #selector(pressedCurrencyBtn), for: .touchUpInside)
    }
    
    private func setConstraints() {
        amountExpenseTF.translatesAutoresizingMaskIntoConstraints = false
        currencyAmountBtn.translatesAutoresizingMaskIntoConstraints = false
        currencyShortLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amountExpenseTF.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountExpenseTF.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            amountExpenseTF.trailingAnchor.constraint(equalTo: currencyShortLabel.leadingAnchor, constant: -16),
            amountExpenseTF.heightAnchor.constraint(equalToConstant: 40),
            
            currencyShortLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyAmountBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            currencyAmountBtn.heightAnchor.constraint(equalToConstant: 40),
            currencyAmountBtn.widthAnchor.constraint(equalToConstant: 40),
            
            currencyShortLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            currencyShortLabel.trailingAnchor.constraint(equalTo: currencyAmountBtn.leadingAnchor, constant: -8)
        ])
    }
    
    @objc
    private func pressedCurrencyBtn() {
        delegate?.pressedCurrencyBtn()
    }
}


// MARK: - UITextFieldDelegate

extension AmountExpenseCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard let amountDouble = Double(text) else { return }
        delegate?.amountExpense(amount: amountDouble)
    }
}

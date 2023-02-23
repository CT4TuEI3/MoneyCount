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
    
    // MARK: UI Elements
    
    private let amountExpenseTF = UITextField()
    private let currencyAmountBtn = UIButton()
    private let currencyShortLabel = UILabel()
    
    
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
        amountExpenseTF.placeholder = placeholder
    }
    
    
    // MARK: - Private methods
    
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
    
    
    // MARK: - Actions
    
    @objc
    private func pressedCurrencyBtn() {
        delegate?.pressedCurrencyBtn()
    }
}


// MARK: - UITextFieldDelegate

extension AmountExpenseCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.amountExpense(amount: text.isEmpty ? 0.0 : (Double(text) ?? 0))
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
    }
}


// MARK: - String

extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            let digits = split.count == 2 ? split.last ?? "" : ""
            let char = String(digits.filter { digits.contains($0)})
            return char.count <= maxDecimalPlaces
        }
        return false
    }
}


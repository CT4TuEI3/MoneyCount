//
//  DateExpenseCell.swift
//  MoneyCount
//
//  Created by Алексей on 31.01.2023.
//

import UIKit

protocol DateExpenseCellDelegate: AnyObject {
    func dateExpense(date: String)
}

final class DateExpenseCell: UITableViewCell {
    
    // MARK: - Properties

    weak var delegate: DateExpenseCellDelegate?
    
    
    // MARK: - private properties

    private var dateExpense = ""
    
    
    // MARK: - UI Elements
    
    private let dateField = UITextField()
    private let dateExpenseDatePicker = UIDatePicker()
    private let datePickerToolBar = UIToolbar()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.addSubview(dateField)
        setConstraints()
        setiingsTextField()
        settingsDatePicker()
    }
    
    private func setiingsTextField() {
        dateField.translatesAutoresizingMaskIntoConstraints = false
        dateField.inputView = dateExpenseDatePicker
        dateField.placeholder = "Pick date"
    }
    
    private func settingsDatePicker() {
        dateExpenseDatePicker.translatesAutoresizingMaskIntoConstraints = false
        dateExpenseDatePicker.locale = .current
        dateExpenseDatePicker.datePickerMode = .date
        dateExpenseDatePicker.preferredDatePickerStyle = .wheels
        dateExpenseDatePicker.addTarget(self, action: #selector(self.changeDate), for: .valueChanged)
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        datePickerToolBar.sizeToFit()
        datePickerToolBar.setItems([flexSpace, doneBtn], animated: true)
        dateField.inputAccessoryView = datePickerToolBar
    }
    
    private func getDataFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        dateField.text = formatter.string(from: dateExpenseDatePicker.date)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateField.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    
    // MARK: - Actions
    
    @objc
    private func changeDate(sender: UIDatePicker) {
        //        let dateFormat = DateFormatter()
        //        dateFormat.dateStyle = .long
        //        dateFormat.timeStyle = .none
        //        dateField.text = dateFormat.string(from: sender.date)
    }
    
    @objc
    private func doneAction() {
        getDataFromPicker()
        contentView.endEditing(true)
        delegate?.dateExpense(date: dateField.text ?? "")
    }
}

//
//  PaidByCell.swift
//  MoneyCount
//
//  Created by Алексей on 3.03.2023.
//

import UIKit

protocol PaidByCellDelegate: AnyObject {
    func selectedPaidName(selectedName: String)
}

final class PaidByCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: PaidByCellDelegate?
    
    
    // MARK: - Private property
    
    private var paidNames: [String] = []
    
    
    // MARK: - UI Elements
    
    private let paidByNameTextField = UITextField()
    private let selectPaidNamePickerView = UIPickerView()
    private let pickerNameToolBar = UIToolbar()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(names: [NameBalanceModel]) {
        names.forEach {
            paidNames.append($0.name)
        }
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(paidByNameTextField)
        settingsUI()
        setConstraints()
    }
    
    private func settingsUI() {
        paidByNameTextField.inputView = selectPaidNamePickerView
        paidByNameTextField.inputAccessoryView = pickerNameToolBar
        paidByNameTextField.placeholder = "Paid by"
        
        selectPaidNamePickerView.delegate = self
        selectPaidNamePickerView.dataSource = self
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerNameToolBar.sizeToFit()
        pickerNameToolBar.setItems([flexSpace, doneBtn], animated: true)
        pickerNameToolBar.isUserInteractionEnabled = true
    }
    
    private func setConstraints() {
        paidByNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paidByNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            paidByNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            paidByNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func doneAction() {
        if paidByNameTextField.text == "" {
            paidByNameTextField.text = paidNames.first
        }
        contentView.endEditing(true)
        delegate?.selectedPaidName(selectedName: paidByNameTextField.text ?? "")
    }
}


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension PaidByCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        paidNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        paidNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paidByNameTextField.text = paidNames[row]
    }
}

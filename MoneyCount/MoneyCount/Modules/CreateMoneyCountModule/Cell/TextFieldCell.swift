//
//  InputCell.swift
//  MoneyCount
//
//  Created by Алексей on 23.01.2023.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func pressedDoneBtn(title: String, text: String)
}

class TextFieldCell: UITableViewCell {
    
    weak var delegate: TextFieldCellDelegate?
    private var title: String = ""
    
    
    //MARK: - UI Elements
    
    private let titleMCTextField = UITextField()
    

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
        title = placeholder
        titleMCTextField.placeholder = placeholder
        titleMCTextField.delegate = self
    }
    
    
    //MARK: - Private methods
    
    private func setupUI() {
        contentView.addSubview(titleMCTextField)
        settingsTextFields()
        setConstraints()
    }
    
    private func settingsTextFields(){
        titleMCTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleMCTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleMCTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleMCTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleMCTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}


extension TextFieldCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.pressedDoneBtn(title: title, text: text)
    }
}

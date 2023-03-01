//
//  CustomSettingsHeadder.swift
//  MoneyCount
//
//  Created by Алексей on 1.03.2023.
//

import UIKit

protocol CustomSettingsHeadderDelegate: AnyObject {
    func isAllSelected(forSection: Int)
}

final class CustomSettingsHeadder: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CustomSettingsHeadderDelegate?
    
    
    // MARK: - Private propertyes
    
    private let sectionNumber: Int
    
    
    // MARK: - UI Elements
    
    private let equallyButton = UIButton()
    private let equallyLabel = UILabel()
    
    
    // MARK: - Life cycle
    
    init(forSection: Int, color: UIColor) {
        self.sectionNumber = forSection
        super.init(frame: .zero)
        
        self.backgroundColor = color
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        addSubview(equallyButton)
        addSubview(equallyLabel)
        settingsUIElements()
        setConstraints()
        
    }
    
    private func settingsUIElements() {
        equallyButton.backgroundColor = .blue
        equallyButton.addTarget(self, action: #selector(forWhomPressedButton), for: .touchUpInside)
        
        equallyLabel.text = "For whom:"
    }
    
    private func setConstraints() {
        equallyButton.translatesAutoresizingMaskIntoConstraints = false
        equallyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            equallyButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            equallyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            equallyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            equallyLabel.trailingAnchor.constraint(equalTo: equallyButton.leadingAnchor, constant: -8)
        ])
    }
    
    
    // MARK: - Actions
    
    @objc
    private func forWhomPressedButton() {
        delegate?.isAllSelected(forSection: sectionNumber)
    }
}


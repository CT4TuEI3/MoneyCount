//
//  ViewController.swift
//  MoneyCount
//
//  Created by Алексей on 17.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private propertyes
    
    private let cellIdentifire = "Title"
    
    
    // MARK: - UI Elements
    
    private let moneyCountTableView = UITableView()
    private let mainButton = UIButton()
    private let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        title = "MoneyCount"
        view.backgroundColor = .systemBackground
        
        view.addSubview(moneyCountTableView)
        view.addSubview(mainButton)
        
        settingsTable()
        settingsMainButton()
        settingsAlert()
        setConstraints()
    }
    
    private func settingsTable() {
        moneyCountTableView.delegate = self
        moneyCountTableView.dataSource = self
        moneyCountTableView.rowHeight = 64
        moneyCountTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
        moneyCountTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func settingsMainButton() {
        mainButton.setImage(UIImage(named: "plusButton"), for: .normal)
        mainButton.configuration?.imagePadding = 0
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.addTarget(self, action: #selector(pressedMainButton), for: .touchUpInside)
    }
    
    private func settingsAlert() {
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            print("Crete")
        }))
        alert.addAction(UIAlertAction(title: "Join", style: .default, handler: { _ in
            print("Join")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moneyCountTableView.topAnchor.constraint(equalTo: view.topAnchor),
            moneyCountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moneyCountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moneyCountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            mainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainButton.widthAnchor.constraint(equalToConstant: 56),
            mainButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc private func pressedMainButton() {
        present(alert, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        cell.backgroundColor = .systemBackground
        return cell
    }
}

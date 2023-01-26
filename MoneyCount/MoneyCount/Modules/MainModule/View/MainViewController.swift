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
        view.backgroundColor = .systemBackground
        
        view.addSubview(moneyCountTableView)
        settingsTable()
        settingNavigationBar()
        settingsAlert()
        setConstraints()
    }
    
    private func settingsTable() {
        moneyCountTableView.backgroundColor = .systemGray6
        moneyCountTableView.delegate = self
        moneyCountTableView.dataSource = self
        moneyCountTableView.rowHeight = 64
        moneyCountTableView.register(CustomMoneyCountCell.self, forCellReuseIdentifier: cellIdentifire)
        moneyCountTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func settingNavigationBar() {
        title = "MoneyCount"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedPlusButton))
        
    }
    
    private func settingsAlert() {
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            self?.pressedCreateButton()
        }))
        
        alert.addAction(UIAlertAction(title: "Join", style: .default, handler: { _ in
            print("Join")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }
    
    private func pressedCreateButton() {
        navigationController?.pushViewController(CreateCountVC(), animated: true)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moneyCountTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moneyCountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moneyCountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moneyCountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    // MARK: - Actions
    
    @objc private func pressedPlusButton() {
        present(alert, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? CustomMoneyCountCell
        cell?.configure(title: "Title", discription: "Discription")
        return cell ?? UITableViewCell()
    }
}

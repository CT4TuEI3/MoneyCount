//
//  ViewController.swift
//  MoneyCount
//
//  Created by Алексей on 17.01.2023.
//

import UIKit

final class StartVC: UIViewController {
    
    // MARK: - Private propertyes
    
    private let service = FireBaseService()
    private let userDefaultsService = UserDefaultsService()
    private let cellIdentifire = "Title"
    private var moneyCountTitle = ""
    private var moneyCountDiscription = ""
    private var names: [NameBalanceModel] = []
    
    
    // MARK: - UI Elements
    
    private let moneyCountTableView = UITableView()
    private let mainButton = UIButton()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private var rightBarButtonItem = UIBarButtonItem()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = false
        setData()
        checkSeensPresentation()
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setData() {
        loadingIndicator.startAnimating()
        service.getData { [weak self] result in
            self?.view.isUserInteractionEnabled = true
            self?.rightBarButtonItem.isEnabled = true
            switch result {
                case .success(let data):
                    self?.loadingIndicator.stopAnimating()
                    self?.moneyCountTitle = data.title
                    self?.moneyCountDiscription = data.description
                    self?.names = data.names
                    self?.moneyCountTableView.reloadData()
                case .failure(let error):
                    let errorAlert = UIAlertController(title: "Eror",
                                                       message: error.localizedDescription,
                                                       preferredStyle: .alert )
                    errorAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
                    self?.present(errorAlert, animated: true)
                    print(error)
            }
        }
    }
    
    private func checkSeensPresentation() {
        if !userDefaultsService.getData(forKey: .isWasFirstRunApp) {
            present(PresentationVC(), animated: true)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(moneyCountTableView)
        view.addSubview(loadingIndicator)
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
    }
    
    
    private func settingNavigationBar() {
        title = "MoneyCount"
        rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(pressedPlusButton))
        rightBarButtonItem.isEnabled = false
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
        let vc = CreateCountVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setConstraints() {
        moneyCountTableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moneyCountTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moneyCountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moneyCountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moneyCountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    // MARK: - Actions
    
    @objc
    private func pressedPlusButton() {
        present(alert, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension StartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? CustomMoneyCountCell
        cell?.configure(title: moneyCountTitle, discription: moneyCountDiscription)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(MainMoneyCountVC(names: names,
                                                                  titleMoneyCount: moneyCountTitle),
                                                 animated: true)
    }
}

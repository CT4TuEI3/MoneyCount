//
//  MainMoneyCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 26.01.2023.
//

import UIKit

final class MainMoneyCountVC: UITabBarController {
    
    let names: [String]
    
    // MARK: - Life Cycle
    
    init(names: [String]) {
        self.names = names
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        settingsNavigationBar()
        settingsTabBar()
    }
    
    private func settingsNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(pressedBtn))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedAddExpensButton))
    }
    
    private func settingsTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.barStyle = .default
        let expensesVC = ExpensesVC()
        let item = UITabBarItem(title: "Expenses",
                                image: UIImage(systemName: "doc.text"),
                                selectedImage: nil)
        expensesVC.tabBarItem = item
        let balancesVC = UIViewController()
        let itemsec = UITabBarItem(title: "Balances",
                                   image: UIImage(systemName: "arrow.left.arrow.right"),
                                   selectedImage: nil)
        balancesVC.tabBarItem = itemsec
        setViewControllers([expensesVC, balancesVC], animated: true)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func pressedBtn(){
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc
    private func pressedAddExpensButton() {
        navigationController?.pushViewController(AddExpenseVC(names: names), animated: true)
    }
}



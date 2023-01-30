//
//  MainMoneyCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 26.01.2023.
//

import UIKit

final class MainMoneyCountVC: UITabBarController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .green
        settingsNavigationBar()
        settingsTabBar()
    }
    
    private func settingsNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(pressedBtn))
    }
    
    private func settingsTabBar() {
        tabBar.backgroundColor = .systemGray4
        tabBar.barStyle = .default
        let expensesVC = ExpensesVC()
        expensesVC.view.backgroundColor = .systemGray5
        
        let item = UITabBarItem(title: "Expenses",
                                image: UIImage(systemName: "doc.text"),
                                selectedImage: nil)
        expensesVC.tabBarItem = item
        
        let balancesVC = UIViewController()
        balancesVC.view.backgroundColor = .systemGray6
        
        let itemsec = UITabBarItem(title: "Balances",
                                   image: UIImage(systemName: "arrow.left.arrow.right"),
                                   selectedImage: nil)
        balancesVC.tabBarItem = itemsec
        
        setViewControllers([expensesVC, balancesVC], animated: true)
    }
    
    
    // MARK: - Actions
    
    @objc func pressedBtn(){
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
}



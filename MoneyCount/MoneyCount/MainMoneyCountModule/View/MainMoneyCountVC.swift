//
//  MainMoneyCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 26.01.2023.
//

import UIKit

final class MainMoneyCountVC: UITabBarController {
    
    // MARK: - Private propertyes
    
    private let namesUsersOneMoneyCount: [NameBalanceModel]
    private let titleMoneyCount: String
    private var isNeedUpdated = false
    private var currencyMC: String
    
    
    // MARK: - Life Cycle
    
    init(names: [NameBalanceModel], titleMoneyCount: String, currency: String) {
        self.currencyMC = currency
        self.namesUsersOneMoneyCount = names
        self.titleMoneyCount = titleMoneyCount
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backBtn))
        title = titleMoneyCount
        view.backgroundColor = .systemBackground
        settingsTabBar()
    }
    
    private func settingsTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.barStyle = .default
        let expensesVC = ExpensesVC(docTitle: titleMoneyCount)
        expensesVC.delegate = self
        let item = UITabBarItem(title: "Expenses",
                                image: UIImage(systemName: "doc.text"),
                                selectedImage: nil)
        expensesVC.tabBarItem = item
        let balancesVC = BalancesVC(names: namesUsersOneMoneyCount)
        balancesVC.delegate = self
        let itemsec = UITabBarItem(title: "Balances",
                                   image: UIImage(systemName: "arrow.left.arrow.right"),
                                   selectedImage: nil)
        balancesVC.tabBarItem = itemsec
        setViewControllers([expensesVC, balancesVC], animated: true)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func pressedAddExpensButton() {
        let vc = AddExpenseVC(names: namesUsersOneMoneyCount,
                              currency: currencyMC,
                              titleMoneyCount: titleMoneyCount)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func pressedBtnBalance() {
        
    }
    
    @objc
    private func backBtn() {
        navigationController?.popToRootViewController(animated: true)
    }
}


// MARK: - ExpensesVCDelegate

extension MainMoneyCountVC: ExpensesVCDelegate {
    func isNeedUpdateddData(_ completion: @escaping (Bool) -> Void) {
        completion(isNeedUpdated)
        isNeedUpdated = false
    }
    
    func updatedNavBarBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedAddExpensButton))
    }
}


// MARK: - BalancesVCDelegate

extension MainMoneyCountVC: BalancesVCDelegate {
    func updateNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedBtnBalance))
    }
}


// MARK: - AddExpenseVCDDelegate

extension MainMoneyCountVC: AddExpenseVCDDelegate {
    func updatedExpenses() {
        isNeedUpdated = true
    }
}

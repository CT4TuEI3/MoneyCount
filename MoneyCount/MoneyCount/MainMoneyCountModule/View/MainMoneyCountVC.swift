//
//  MainMoneyCountVC.swift
//  MoneyCount
//
//  Created by Алексей on 26.01.2023.
//

import UIKit

final class MainMoneyCountVC: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(pressedBtn))
        
    }
    
    @objc func pressedBtn(){
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
}

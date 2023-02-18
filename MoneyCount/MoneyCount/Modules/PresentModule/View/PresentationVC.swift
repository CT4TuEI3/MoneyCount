//
//  PresentationVC.swift
//  MoneyCount
//
//  Created by Алексей on 10.02.2023.
//

import UIKit

final class PresentationVC: UIViewController {
    
    // MARK: - Private propertyes
    
    private let cellIdentifire = "cellIdentifire"
    private var presentationData: [PresentationModel] = []
    
    // MARK: - UI Elements
    
    private let appIconImage = UIImageView()
    private let welcomeText = UILabel()
    private let presentTableView = UITableView(frame: .zero, style: .plain)
    private let continueButton = UIButton()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setup()
    }
    
    
    // MARK: - Private Methods
    
    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(appIconImage)
        view.addSubview(welcomeText)
        view.addSubview(presentTableView)
        view.addSubview(continueButton)
        appIconImage.image = UIImage(systemName: "apps.iphone")
        textWelcomeSettings()
        tableViewSettings()
        buttonSettings()
        settingsConstraints()
    }
    
    private func setData() {
        presentationData.append(PresentationModel(imageName: "dollarsign.circle",
                                                  titleText: "Your personal helper",
                                                  discriptionText: "You paid for a hotel, Timur covered the fuel costs and Dmitry ddid some shoping. MoneyCount does the math for you"))
        presentationData.append(PresentationModel(imageName: "doc.text",
                                                  titleText: "Add expenses",
                                                  discriptionText: "Create your MoneyCount. Let everyone add their expenses and then view the total cost"))
        presentationData.append(PresentationModel(imageName: "arrow.left.arrow.right",
                                                  titleText: "Balance",
                                                  discriptionText: "Everyone can check their current balance on their iPhone at anytime"))
    }
    private func textWelcomeSettings() {
        welcomeText.text = "Welcome to\nMoneyCount"
        welcomeText.font = UIFont(name: "Galvji-Bold", size: 40)
        welcomeText.textAlignment = .center
        welcomeText.numberOfLines = 0
    }
    
    private func tableViewSettings() {
        presentTableView.delegate = self
        presentTableView.dataSource = self
        presentTableView.register(PresentationCell.self, forCellReuseIdentifier: cellIdentifire)
    }
    
    private func buttonSettings() {
        continueButton.backgroundColor = .systemBlue
        continueButton.layer.cornerRadius = 15
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        continueButton.addTarget(self, action: #selector(pressedContinueBtn), for: .touchUpInside)
    }
    
    private func settingsConstraints() {
        appIconImage.translatesAutoresizingMaskIntoConstraints = false
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        presentTableView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appIconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIconImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            appIconImage.widthAnchor.constraint(equalToConstant: 120),
            appIconImage.heightAnchor.constraint(equalToConstant: 120),
            
            welcomeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeText.topAnchor.constraint(equalTo: appIconImage.bottomAnchor, constant: 40),
            
            presentTableView.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 20),
            presentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presentTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            continueButton.heightAnchor.constraint(equalToConstant: 60),
            continueButton.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    
    // MARK: - Actions
    
    @objc private func pressedContinueBtn() {
        dismiss(animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension PresentationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presentationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? PresentationCell
        cell?.configure(image: presentationData[indexPath.row].imageName,
                        title: presentationData[indexPath.row].titleText,
                        discription: presentationData[indexPath.row].discriptionText)
        return cell ?? UITableViewCell()
    }
}

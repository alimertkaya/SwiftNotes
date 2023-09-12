//
//  ViewController.swift
//  ProtocolOrientedUIKit
//
//  Created by Ali Mert Kaya on 12.09.2023.
//

import UIKit

class UserViewController: UIViewController, UserViewModelOutput {
    
    private let viewModel : UserViewModel
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        // constraintleri kendimiz vericeğiz diye
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        // fetchUsers()
        viewModel.fetchUsers()
    }
    
    // Delegate Pattern olduğu için bu kadar kolay aldık verileri
    func update(name: String, email: String, userName: String) {
        self.nameLabel.text = name
        self.usernameLabel.text = userName
        self.emailLabel.text = email
    }
    
    private func setupViews() {
        
        view.backgroundColor = .yellow
        
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate(
            [
                
                // merkeze yerleştir
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameLabel.heightAnchor.constraint(equalToConstant: 60),
                nameLabel.widthAnchor.constraint(equalToConstant: 200),
                nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                
                emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emailLabel.heightAnchor.constraint(equalToConstant: 60),
                emailLabel.widthAnchor.constraint(equalToConstant: 200),
                emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
                
                usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                usernameLabel.heightAnchor.constraint(equalToConstant: 60),
                usernameLabel.widthAnchor.constraint(equalToConstant: 200),
                usernameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2)
            ]
        )
    }
    
    /*
    private func fetchUsers() {
        APIManager.shared.fetchUser { result in
            switch result {
            case .success(let user):
                self.usernameLabel.text = user.username
                self.emailLabel.text = user.email
                self.nameLabel.text = user.name
                
            case .failure:
                self.nameLabel.text = "No user found"
            }
        }
    }
     */
}

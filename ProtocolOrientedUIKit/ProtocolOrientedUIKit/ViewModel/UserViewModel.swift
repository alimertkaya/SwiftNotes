//
//  UserViewModel.swift
//  ProtocolOrientedUIKit
//
//  Created by Ali Mert Kaya on 12.09.2023.
//

import Foundation

class UserViewModel {
    
    private let userService : UserService
    // weak -> bu değişken sadece erişildiğinde init edilecek
    weak var output : UserViewModelOutput?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUsers() {
        
        // [weak self] -> weak var bir değilken tanımladığımız için ekledik
        userService.fetchUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.update(name: user.name, email: user.email, userName: user.username)
            case .failure(_):
                self?.output?.update(name: "No User", email: "", userName: "")
            }
        }
    }
}

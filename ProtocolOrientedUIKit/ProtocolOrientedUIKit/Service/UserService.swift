//
//  UserService.swift
//  ProtocolOrientedUIKit
//
//  Created by Ali Mert Kaya on 12.09.2023.
//

import Foundation

protocol UserService {
    func fetchUser(completion: @escaping(Result<User,Error>) -> Void)
}

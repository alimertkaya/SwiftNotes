//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Ali Mert Kaya on 9.08.2023.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
}

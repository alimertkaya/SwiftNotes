//
//  UserViewModelOutput.swift
//  ProtocolOrientedUIKit
//
//  Created by Ali Mert Kaya on 12.09.2023.
//

import Foundation

// Verileri UserViewModel -> UserVC e aktarmak için oluşturuyoruz
// AnyObject -> tanımlanan değişkeni weak yapabilmek için
protocol UserViewModelOutput : AnyObject {
    func update(name: String, email: String, userName: String)
}

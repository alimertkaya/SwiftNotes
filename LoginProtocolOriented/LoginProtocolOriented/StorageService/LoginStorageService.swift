//
//  LoginStorageService.swift
//  LoginProtocolOriented
//
//  Created by Ali Mert Kaya on 13.09.2023.
//

import Foundation

protocol LoginStorageService {
    var userAccessTokenKey : String { get }
    func setUserAccessToken(token : String)
    func getUserAccessToken() -> String?
}

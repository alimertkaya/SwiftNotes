//
//  APIManager.swift
//  ProtocolOrientedUIKit
//
//  Created by Ali Mert Kaya on 12.09.2023.
//

import Foundation

class APIManager : UserService {
    
    /*
    static let shared = APIManager()
    private init() {}
     */
    
    func fetchUser(completion: @escaping(Result<User,Error>) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                if let user = try? JSONDecoder().decode([User].self, from: data).first {
                    completion(.success(user))
                } else {
                    completion(.failure(NSError()))
                }
            }
        }.resume()
    }
}

//
//  CryptoCurrency.swift
//  CryptoCrazySwiftUI
//
//  Created by Ali Mert Kaya on 15.08.2023.
//

import Foundation

struct CryptoCurrency : Hashable , Decodable, Identifiable {
    
    let id = UUID()
    let currency : String
    let price : String
    
    // Data çekilen API de belki price değilde pRi2C gibi olabilir o yüzden CodingKey kullandık, id olduğu için sıkıntı çıkmaması içinde
    private enum CodingKeys : String, CodingKey {
        case currency = "currency"
        case price = "price"
    }
}

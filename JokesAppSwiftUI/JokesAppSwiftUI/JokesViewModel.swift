//
//  JokesViewModel.swift
//  JokesAppSwiftUI
//
//  Created by Ali Mert Kaya on 18.08.2023.
//

import Foundation
import Alamofire

class JokesViewModel : ObservableObject {
    
    @Published var jokes = [Value]()
    
    // ViewModel oluşturulduğunda çalıştırılsın diye
    init() {
        getJokes()
    }
    
    func getJokes(count: Int = 4) {
        
        // of: -> Nerden decode edileceği belirtilir
        AF.request("https://raw.githubusercontent.com/atilsamancioglu/JokesAppJsonData/main/chuck.json", method: .get).responseDecodable(of: JokesData.self) { response in
            
            switch response.result {
                
            case.success(let data):
                let value = data.value
                self.jokes += value
            case.failure(let error):
                print(error)
            }
        }
    }
}

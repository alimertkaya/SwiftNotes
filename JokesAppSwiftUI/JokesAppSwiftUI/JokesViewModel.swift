//
//  JokesViewModel.swift
//  JokesAppSwiftUI
//
//  Created by Ali Mert Kaya on 18.08.2023.
//

import Foundation

class JokesViewModel : ObservableObject {
    
    @Published var jokes = [Value]()
    
    func getJokes() {
        
    }
}

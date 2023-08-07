//
//  MusicianStruct.swift
//  AdvancedSwiftProject
//
//  Created by Ali Mert Kaya on 7.08.2023.
//

import Foundation

struct MusicianStruct {
    
    var name : String
    var age : Int
    var instrument : String
    
    // Struct larda init func zorunlu değil, oluşturmaya gerek yok
    
    mutating func happyBirthday() {
        self.age += 1
    }
}

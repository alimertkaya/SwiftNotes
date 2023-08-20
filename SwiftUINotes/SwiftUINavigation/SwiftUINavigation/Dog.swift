//
//  Dog.swift
//  SwiftUINavigation
//
//  Created by Ali Mert Kaya on 20.08.2023.
//

import Foundation

// Hashable -> Başka yere yollamak için tanımlandı

struct Dog: Identifiable, Hashable {
    var id = UUID()
    let name : String
}

let dogs : [Dog] = [Dog(name: "Lucky"), Dog(name: "Daisy"), Dog(name: "Jack"), Dog(name: "Barley")]

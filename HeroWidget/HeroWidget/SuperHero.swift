//
//  SuperHero.swift
//  HeroWidget
//
//  Created by Ali Mert Kaya on 14.08.2023.
//

import Foundation

struct SuperHero : Identifiable, Codable {
    let image : String
    let name : String
    let realName : String
    var id : String {image}
}

let superman = SuperHero(image: "superman", name: "Superman", realName: "Clark Kent")
let batman = SuperHero(image: "batman", name: "Batman", realName: "Bruce Wayne")
let ironman = SuperHero(image: "ironman", name: "Iron Man", realName: "Tony Stark")

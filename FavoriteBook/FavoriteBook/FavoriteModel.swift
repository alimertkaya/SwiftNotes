//
//  FavoriteModel.swift
//  FavoriteBook
//
//  Created by Ali Mert Kaya on 8.08.2023.
//

import Foundation

struct FavoriteModel : Identifiable{
    var id = UUID()
    var title : String
    var elements : [FavoriteElements]
    
}

struct FavoriteElements : Identifiable {
    var id = UUID()
    var name : String
    var imageName : String
    var description : String
}

let colosseum = FavoriteElements(name: "Colosseum", imageName: "colosseum", description: "Italy")
let greatWall = FavoriteElements(name: "Great Wall", imageName: "greatwall", description: "China")
let kremlin = FavoriteElements(name: "Kremlin", imageName: "kremlin", description: "Russia")
let favoritePlaces = FavoriteModel(title: "Favorite Places", elements: [colosseum,greatWall,kremlin])

let lotr = FavoriteElements(name: "The Lord of The Rings", imageName: "lotr", description: "Tolkien")
let starWars = FavoriteElements(name: "Star Wars", imageName: "starwars", description: "Disney")
let interstellar = FavoriteElements(name: "Interstellar", imageName: "interstellar", description: "Nolan")
let favoriteMovies = FavoriteModel(title: "Favorite Movies", elements: [lotr,starWars,interstellar])

let myFavorites = [favoritePlaces, favoriteMovies]

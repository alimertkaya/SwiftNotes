//
//  ContentView.swift
//  HeroWidget
//
//  Created by Ali Mert Kaya on 14.08.2023.
//

import SwiftUI

let superHeroArray = [superman,batman,ironman]

struct ContentView: View {
    
    var body: some View {
        VStack {
            ForEach(superHeroArray) { hero in
                HeroView(hero: hero)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

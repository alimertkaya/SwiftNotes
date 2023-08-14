//
//  ContentView.swift
//  HeroWidget
//
//  Created by Ali Mert Kaya on 14.08.2023.
//

import SwiftUI
import WidgetKit

let superHeroArray = [superman,batman,ironman]

struct ContentView: View {
    
    @AppStorage("hero", store: UserDefaults(suiteName: "group.com.alimertkaya.HeroWidget"))
    var heroData : Data = Data()
    
    var body: some View {
        VStack {
            ForEach(superHeroArray) { hero in
                HeroView(hero: hero).onTapGesture {
                    saveToDefaults(hero: hero)
                }
            }
        }
    }
    
    func saveToDefaults(hero : SuperHero) {
        // print(hero.name)
        
        if let heroData = try? JSONEncoder().encode(hero) {
            self.heroData = heroData
            print(hero.name)
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetHero")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

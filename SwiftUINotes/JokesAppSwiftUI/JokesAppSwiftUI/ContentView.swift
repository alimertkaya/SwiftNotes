//
//  ContentView.swift
//  JokesAppSwiftUI
//
//  Created by Ali Mert Kaya on 18.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var JokesVM = JokesViewModel()
    
    var body: some View {
        NavigationView {
            List(JokesVM.jokes) { element in
                Text(element.joke)
            }
            .toolbar {
                Button {
                    addJoke()
                } label: {
                    Text("Get New Joke")
                }

            }
            .navigationTitle(Text("Jokes App"))
        }
    }
    
    func addJoke() {
        JokesVM.getJokes()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

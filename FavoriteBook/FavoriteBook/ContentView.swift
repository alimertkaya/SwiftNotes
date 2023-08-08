//
//  ContentView.swift
//  FavoriteBook
//
//  Created by Ali Mert Kaya on 8.08.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(myFavorites) { favorite in
                    Section(header: Text(favorite.title)) {
                        ForEach(favorite.elements) { element in
                            NavigationLink(destination: DetailsView()) {
                                Text(element.name)
                            }
                        }
                    }
                }
            }.navigationBarTitle(Text("Favorite Book"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

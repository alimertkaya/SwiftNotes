//
//  ThirdView.swift
//  FirstSwiftUIApp
//
//  Created by Ali Mert Kaya on 8.08.2023.
//

import SwiftUI

struct ThirdView: View {
    
    let myArray = ["Aragorn", "Legolas", "Gandalf", "Frodo", "Galadriel"]
    
    var body: some View {
        
        List (myArray, id: \.self) { element in
            Image("colosseum").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30)
            Text(element)}.font(.largeTitle)
         
        /*
        List {
            ForEach(myArray, id: \.self) {
                element in Text(element)
            }
        }
         */
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}

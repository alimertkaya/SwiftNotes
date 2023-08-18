//
//  FifthView.swift
//  FirstSwiftUIApp
//
//  Created by Ali Mert Kaya on 8.08.2023.
//

import SwiftUI

struct FifthView: View {
    
    @State var name = "Aragorn"
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .padding()
            TextField("placeholder", text: $name)

        }
    }
}

struct FifthView_Previews: PreviewProvider {
    static var previews: some View {
        FifthView()
    }
}

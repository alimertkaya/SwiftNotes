//
//  FourthView.swift
//  FirstSwiftUIApp
//
//  Created by Ali Mert Kaya on 8.08.2023.
//

import SwiftUI

struct FourthView: View {
    
    @State var name = "Aragorn"
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .padding()
            
            Button {
                self.name = "Gandalf"
            } label: {
                Text("MyButton")
            }


        }
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}

//
//  CircularImageView.swift
//  HeroWidget
//
//  Created by Ali Mert Kaya on 14.08.2023.
//

import SwiftUI

struct CircularImageView: View {
    var image : Image
    var body: some View {
        image.resizable()
            .aspectRatio(contentMode: .fit)
        // Hangi şekle göre kesilsin
            .clipShape(Circle())
        // Etrafına halka verir
            .overlay(Circle().stroke(Color.purple,lineWidth: 5))
            .shadow(radius: 15)
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(image: Image("batman"))
    }
}

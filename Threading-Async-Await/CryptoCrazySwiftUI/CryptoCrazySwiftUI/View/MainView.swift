//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Ali Mert Kaya on 15.08.2023.
//

import SwiftUI

struct MainView: View {
    
    // Gözlemnenen nesne
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    // Görünüm oluşturulduğunda ilk çağrılır
    init() {
        // Boş bir şekilde tanımlandı
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView {
            List(cryptoListViewModel.cryptoList, id:\.id) { crypto in
                VStack {
                    Text(crypto.currency!)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                    Text(crypto.price!)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity ,alignment: .leading)
                }
            }.toolbar(content: {
                Button {
                    // button clicked
                    Task.init {
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    }
                } label: {
                    Text("Refresh")
                }

            })
            .navigationTitle("Crypto Crazy")
            // onAppear -> View oluşturulduğunda ne olucak
                .task {
                    
                    await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                    
                    // await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
                }
            /*
             }.onAppear() {
             cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
             }
             */
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
}

//
//  ContentView.swift
//  Concurrency
//
//  Created by Noye Samuel on 03/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel  = UnsplashViewModel(dataService: NetworkManager())
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }.onAppear {
        
        }.padding()
    }
    
}


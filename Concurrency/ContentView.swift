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
        NavigationView {
            VStack {
                SearchView()
                List(viewModel.images) { photo in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: photo.urls.regular)) { phase in
                            switch phase {
                            case .empty:
                                    ProgressView()
                            case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                            case .failure:
                                    Image(systemName: "exclamationmark.icloud.fill")
                                        .foregroundColor(.red)
                            @unknown default:
                                    ProgressView()
                            }
                        }
                        .frame(height: 200)
                    }
                }
            }
            .navigationTitle("Unsplash Photos")
            .onAppear {

            }
        }
    }    
}

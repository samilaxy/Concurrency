//
//  SearchView.swift
//  Concurrency
//
//  Created by Noye Samuel on 03/04/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {

            TextField("Search", text: $searchText)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                
                    }
                )
                .padding(.horizontal)
    
    }
}

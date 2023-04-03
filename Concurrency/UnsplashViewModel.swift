//
//  ImageWrapper.swift
//  Concurrency
//
//  Created by Noye Samuel on 03/04/2023.
//

import Foundation
import Combine
import UIKit

    // Define API wrapper class
class UnsplashViewModel: ObservableObject {
    
    @Published var images: [UnsplashImage] = []
    @Published var isLoading = true
    let dispatchGroup = DispatchGroup()
    var networkManager = NetworkManager()
    
    init(dataService: NetworkManager) {
        self.networkManager = dataService
        self.getImages()
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func getImages() {
        self.isLoading = true
        guard images.isEmpty else { return }
        dispatchGroup.enter()
        networkManager.request()
            .sink { _ in
                self.isLoading = false
            }  receiveValue: { [weak self] returnedimages in
                DispatchQueue.main.async {
                    self?.images = returnedimages
                }
                self?.dispatchGroup.leave()
            }
            .store(in: &cancellables)
        DispatchQueue.main.async {
            print("request:::", self.images)
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.images.shuffle()
            print("request:::", self.images)
        }
    }
}
struct UnsplashImage: Decodable, Identifiable {
    let id: String
    let urls: UnsplashImageUrls
}

struct UnsplashImageUrls: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
class NetworkManager {
    
    func request() -> AnyPublisher<[UnsplashImage], Error> {
        var request =  URLRequest(url: URL(string: "https://api.unsplash.com/photos/random?count=500")!)
        let apiKey = "dixtqIxMkkn0gBKvye_yGfKHH3dUxemwT_QwBFwYW04"
        request.setValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
        return  URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: [UnsplashImage].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

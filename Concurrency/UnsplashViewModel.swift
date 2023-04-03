//
//  ImageWrapper.swift
//  Concurrency
//
//  Created by Noye Samuel on 03/04/2023.
//

import Foundation
import Combine
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
        networkManager.request(endpoint: "photos/random?count=5", type: UnsplashImage.self)
            .sink { _ in
                self.isLoading = false
            }  receiveValue: { [weak self] returnedimages in
                DispatchQueue.main.async {
                    self?.images = returnedimages
                }
                self?.dispatchGroup.leave()
            }
            .store(in: &cancellables)
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.images.shuffle()
            print("request:::", self.images)
        }
    }
    func fetchImages() {
        self.isLoading = true
        guard images.isEmpty else { return }
        dispatchGroup.enter()
        // random
        networkManager.request(endpoint: "photos/random?count=2", type: UnsplashImage.self)
            .sink { _ in
                self.isLoading = false
            }  receiveValue: { [weak self] returnedimages in
                DispatchQueue.main.async {
                    self?.images = returnedimages
                }
                self?.dispatchGroup.leave()
            }
            .store(in: &cancellables)
        dispatchGroup.enter()
       // search with key word
        networkManager.request(endpoint: "search/photos?query=sea&per_page=1", type: UnsplashImage.self)
            .sink { _ in
                self.isLoading = false
            }  receiveValue: { [weak self] returnedimages in
                DispatchQueue.main.async {
                    self?.images = returnedimages
                }
                self?.dispatchGroup.leave()
            }
            .store(in: &cancellables)
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.images.shuffle()
            print("request:::", self.images)
        }
    }
}

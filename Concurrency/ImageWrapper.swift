//
//  ImageWrapper.swift
//  Concurrency
//
//  Created by Noye Samuel on 03/04/2023.
//

import Foundation

    // Define data model for API response
struct UnsplashPhoto: Decodable {
    let id: String
    let description: String?
    let urls: [String: String]
        // Add additional properties as needed
}

    // Define API wrapper class
class UnsplashAPI {
    let baseURL = "https://api.unsplash.com"
    let apiKey = "<YOUR_API_KEY>"
    
        // Make an API request and parse the JSON response into a data model object
    private func request<T: Decodable>(endpoint: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: "\(baseURL)\(endpoint)")!
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.unsplash.api", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned from API"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(type, from: data)
                completion(.success(object))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
        // Search photos by keyword
    func searchPhotos(keyword: String, completion: @escaping (Result<[UnsplashPhoto], Error>) -> Void) {
        let endpoint = "/search/photos?query=\(keyword)&per_page=10"
        request(endpoint: endpoint, type: [UnsplashPhoto].self, completion: completion)
    }
    
        // Get photo by ID
    func getPhoto(id: String, completion: @escaping (Result<UnsplashPhoto, Error>) -> Void) {
        let endpoint = "/photos/\(id)"
        request(endpoint: endpoint, type: UnsplashPhoto.self, completion: completion)
    }
    
        // Add additional API endpoints as needed
}

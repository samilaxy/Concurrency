import Foundation
import Combine

class NetworkManager {
    
    func request<T: Decodable>(endpoint: String, type: T.Type) -> AnyPublisher<[T], Error> {
        let baseURL =  "https://api.unsplash.com/"
        var request =  URLRequest(url: URL(string: "\(baseURL)\(endpoint)")!)
        let apiKey = "dixtqIxMkkn0gBKvye_yGfKHH3dUxemwT_QwBFwYW04"
        request.setValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
        return  URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: [T].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

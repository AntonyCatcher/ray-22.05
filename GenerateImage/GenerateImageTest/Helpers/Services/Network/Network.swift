//
//  Network.swift
//  GenerateImageTest
//
//  Created by Anton  on 24.05.2023.
//

import Foundation

//MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    
    var userQuery: String? { get }
    
    func downloadImage(
        by text: String,
        completion: @escaping (Result<Data, CustomError>) -> Void
    )
}

final class NetworkService {
    
    static let shared = NetworkService()
    var userQuery: String?
    private init() {}
}

extension NetworkService: NetworkServiceProtocol {
    
    func downloadImage(by text: String,
                       completion: @escaping (Result<Data, CustomError>) -> Void) {
        let dummyImageURLString = "https://dummyimage.com"
        let imageSize = "350x350"
        guard let urlString = "\(dummyImageURLString)/\(imageSize)/f0edf0/0f0d0f&text=\(text)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlString)
        else {
            completion(.failure(.urlNotCreate))
            return
        }
        
        userQuery = text
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.internetConnectionLost))
                    return
                }
                guard let data = data
                else {
                    completion(.failure(.dataError))
                    return
                }
                completion(.success(data))
            }
        }
        .resume()
    }
}



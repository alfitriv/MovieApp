//
//  NetworkLayer.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import Foundation

protocol MovieService: AnyObject {
    func fetchResults(searchText: String, successHandler: @escaping (Results) -> Void, errorHandler: @escaping (Error) -> Void)
}

class NetworkLayer: MovieService {
    static var shared = NetworkLayer()
    private init(){}
    
    func fetchResults(searchText: String, successHandler: @escaping (Results) -> Void, errorHandler: @escaping (Error) -> Void) {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: URL(string: "https://itunes.apple.com/search?term=\(searchText)&media=movie")!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
                    guard error == nil else {
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                        return
                    }
                    
                    guard let data = data else {
                        DispatchQueue.main.async {
                            errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                        }
                        return
                    }
                    
                    print(data)
                    
                    do {
                        let results = try JSONDecoder().decode(Results.self, from: data)
                        print(results)
                        DispatchQueue.main.async {
                            successHandler(results)
                        }
                    } catch {
                        fatalError()
                    }
                    
                }.resume()
    }
}

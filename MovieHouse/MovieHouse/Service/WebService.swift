//
//  WebService.swift
//  MovieHouse
//
//  Created by Ali Bahadir Sensoz on 7.11.2023.
//

import Foundation
import Alamofire

class WebService: WebServiceProtocol {
    
    static let shared = WebService()

    private init() {}
    
    private let apiKey = "f74de10a"
    private let baseAPIURL = "https://www.omdbapi.com/"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    
    func fetchMovie(title: String, completion: @escaping (Result<MovieDetails, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)?t=\(title)&apikey=\(apiKey)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    func searchMovie(query: String, page: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        print("Search function called.")
        var currentPage = 1
        var totalResults = 0

        guard var urlComponents = URLComponents(string: "\(baseAPIURL)") else {
            completion(.failure(.invalidEndpoint))
            print("Invalid Endpoint")
            return
        }

        let queryItems = [
            "s": query,
            "apikey": apiKey,
            "page": "\(page)"
        ]

        let params = queryItems.reduce(into: [String: String]()) { $0[$1.key] = $1.value }

        urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents.url else {
            print("Invalid Endpoint 2")
            completion(.failure(.invalidEndpoint))
            return
        }
        
        loadURLAndDecode(url: url, params: params, completion: { (result: Result<Movie, MovieError>) in
            switch result {
            case .success(let movie):
                print("let movie passed")
                totalResults = Int(movie.totalResults) ?? 0
//                for searchResult in movie.search {
//                    // Access and print individual movie details from the array
//                    print("Title: \(searchResult.title)")
//                    print("Year: \(searchResult.year)")
//                    print("Type: \(searchResult.type)")
//                    print("Poster: \(searchResult.poster)")
//                    // You can print other movie properties as needed
//                    print("--------")
//
//                }
            completion(.success(movie))

            case .failure(let error):
                   print("load error 1: \(error.localizedDescription)")

                   let emptyMovie = Movie(search: [], totalResults: "0", response: "False")
                   completion(.success(emptyMovie))
            let totalPages = self.calculateTotalPages(totalResults: totalResults)
                
            if currentPage < totalPages {
                currentPage += 1
                }
            }
            })
        }




    
    func calculateTotalPages(totalResults: Int) -> Int {
        let moviesPerPage = 10
        let totalPages = totalResults / moviesPerPage
        if totalResults % moviesPerPage != 0 {
            return totalPages + 1
        } else {
            return totalPages
        }
    }
    

    

    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }



        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            print(finalURL)
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }

            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }

            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch let error {
                print(error)
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }


    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
    
}

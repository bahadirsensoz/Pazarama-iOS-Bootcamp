//
//  PokemonNetwork.swift
//  Pokedex
//
//  Created by Ali Bahadir Sensoz on 3.11.2023.
//

import Foundation

//class PokemonNetwork: PokemonProtocol {
//
//    
//    
//    static let shared = PokemonProtocol()
//    private init() {}
//    
//    private let baseAPIURL = "https://pokeapi.co/api/v2/"
//    private let urlSession = URLSession.shared
//    private let jsonDecoder = Utils.jsonDecoder
//    
//    static func fetchPokemons(from: Int, to: Int, completion: @escaping (Result<[Pokemon], PokemonError>) -> ()) {
//        var pokemons: [Pokemon] = []
//        let dispatchGroup = DispatchGroup()
//
//        for id in from...to {
//            dispatchGroup.enter()
//            fetchPokemon(withId: id) { result in
//                switch result {
//                case .success(let pokemon):
//                    pokemons.append(pokemon)
//                case .failure(let error): break
//                    // Handle the error if needed
//                }
//                dispatchGroup.leave()
//            }
//        }
//
//        dispatchGroup.notify(queue: .main) {
//            if pokemons.isEmpty {
//                completion(.failure(.noData))
//            } else {
//                completion(.success(pokemons))
//            }
//        }
//    }
//    
//    static func fetchPokemon(withId id: Int, completion: @escaping (Result<Pokemon, PokemonError>) -> ()) {
//        guard let url = URL(string: baseAPIURL + "pokemon/\(id)") else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(.apiError))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//
//            do {
//                let pokemon = try decoder.decode(Pokemon.self, from: data)
//                completion(.success(pokemon))
//            } catch {
//                completion(.failure(.invalidData))
//            }
//        }
//
//        task.resume()
//    }
//    
//    func searchPokemon(query: String, completion: @escaping (Result<Pokemon, PokemonError>) -> ()) {
//        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//        self.loadURLAndDecode(url: url, params: [
//            "query": query
//        ], completion: completion)
//    }
//    
//    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, PokemonError>) -> ()) {
//        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//
//        guard let finalURL = urlComponents.url else {
//            completion(.failure(.invalidEndpoint))
//            return
//        }
//        
//        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
//            guard let self = self else { return }
//            print(finalURL)
//            if error != nil {
//                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
//                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
//                return
//            }
//            
//            guard let data = data else {
//                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
//                return
//            }
//            
//            do {
//                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
//                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
//            } catch let error {
//                print(error)
//                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
//            }
//        }.resume()
//    }
//    
//    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, PokemonError>, completion: @escaping (Result<D, PokemonError>) -> ()) {
//        DispatchQueue.main.async {
//            completion(result)
//        }
//    }
//    
//    
//    
//}
//

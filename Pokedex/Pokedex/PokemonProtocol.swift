//
//  PokemonAPIModel.swift
//  Pokedex
//
//  Created by Ali Bahadir Sensoz on 3.11.2023.
//

import Foundation


protocol PokemonProtocol{
    
//    func fetchPokemons(from endpoint: PokemonListEndpoint,ofset: Int, limit: Int, completion: @escaping (Result<Pokemon, PokemonError>) -> ())
    
    
    static func fetchPokemons(from: Int, to: Int, completion: @escaping (Result<[Pokemon], PokemonError>) -> ())
    
    func fetchPokemon(id: Int, completion: @escaping (Result<Pokemon, PokemonError>) -> ())
        

    func searchPokemon(query: String, completion: @escaping (Result<Pokemon, PokemonError>) -> ())
        
    
    
}

//enum PokemonListEndpoint: String, CaseIterable{
//    case popular
//
//    var description: String {
//        switch self {
//        case .popular: return "popular"
//        }
//    }
//}

enum PokemonError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case noData
    case invalidResponse
    case serializationError
    
    
    var localizedDescription: String{
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
            
        }
    }
    
    var errorUserInfo: [String: Any]{
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}


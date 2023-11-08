//
//  WebServiceProtocol.swift
//  MovieHouse
//
//  Created by Ali Bahadir Sensoz on 7.11.2023.
//

import Foundation


protocol WebServiceProtocol{
            
    
    func fetchMovie(title: String, completion: @escaping (Result<MovieDetails, MovieError>) -> ())
    func searchMovie(query: String, page: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
        
    
    
}

enum MovieListEndpoint: String, CaseIterable{
    case popular
    
    var description: String {
        switch self {
        case .popular: return "popular"
        }
    }
}

enum MovieError: Error, CustomNSError {
    
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

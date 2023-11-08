//
//  MovieModel.swift
//  MovieHouse
//
//  Created by Ali Bahadir Sensoz on 6.11.2023.
//


// MARK: - Movie
struct Movie: Codable {
    var search: [Search]
    let totalResults: String // Keep totalResults as a string
    let response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
    
    // Add a computed property to get totalResults as an integer
    var totalResultsInt: Int {
        return Int(totalResults) ?? 0
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

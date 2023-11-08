//
//  Utils.swift
//  Pokedex
//
//  Created by Ali Bahadir Sensoz on 3.11.2023.
//

import Foundation


class Utils {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
}

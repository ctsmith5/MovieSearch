//
//  Movie.swift
//  MovieSearch
//
//  Created by Colin Smith on 3/22/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation


struct Movie: Codable {
    
    let title: String
    let voteAverage: String
    let overview: String
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case imagePath = "poster_path"
    }
}


struct TopLevelDictionary: Codable {
    let results: [Movie]
    
}

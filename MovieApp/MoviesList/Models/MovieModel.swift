//
//  MovieModel.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 26/12/2023.
//

import Foundation

struct MovieModel: Codable {
    let id: Int
    let posterPath, releaseDate, title: String
    let voteAverage: Double
    let overview: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case overview
    }
}

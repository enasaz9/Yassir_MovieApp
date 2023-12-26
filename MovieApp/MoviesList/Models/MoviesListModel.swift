//
//  MoviesListModel.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 26/12/2023.
//

import Foundation

struct MoviesListModel: Codable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

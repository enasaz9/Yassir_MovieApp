//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 27/12/2023.
//

import Foundation

protocol MovieDetailsViewModelInput {
}

protocol MovieDetailsViewModelOutput {
    var selectedMovie: Observable<MovieModel> { get set }
}

typealias MovieDetailsViewModelProtocols = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

final class MovieDetailsViewModel: MovieDetailsViewModelProtocols {
    
    // MARK: Output
    
    var selectedMovie: Observable<MovieModel> = Observable(MovieModel(id: 0, originalLanguage: "", originalTitle: "", overview: "", popularity: 0.0, posterPath: "", releaseDate: "", title: "", voteAverage: 0.0))
    
    // MARK: init

    init(selectedMovie: MovieModel) {
        self.selectedMovie.value = selectedMovie
    }
}

//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 27/12/2023.
//

import Foundation

protocol MovieDetailsViewModelInput {
    func loadMovieDetails()
}

protocol MovieDetailsViewModelOutput {
    var movieDetails: Observable<MovieModel> { get }
    var showLoading: Observable<Bool> { get }
    var error: Observable<String> { get }
}

typealias MovieDetailsViewModelProtocols = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

final class MovieDetailsViewModel: MovieDetailsViewModelProtocols {
    private let apiManager: APIManagerProtocol
    private let selectedMovieID: String
    
    // MARK: Output
    
    var movieDetails: Observable<MovieModel> = Observable(MovieModel(id: 0, posterPath: "", releaseDate: "", title: "", voteAverage: 0.0, overview: ""))
    let showLoading: Observable<Bool> = Observable(true)
    let error: Observable<String> = Observable("")
    
    // MARK: init

    init(selectedMovieID: String, apiManager: APIManagerProtocol = APIManager()) {
        self.selectedMovieID = selectedMovieID
        self.apiManager = apiManager
    }
    
    func loadMovieDetails() {
        self.showLoading.value = true
        let endpoint = String.init(format: API_Endpoints.movieDetails.rawValue, self.selectedMovieID)
        apiManager.request(endpoint: endpoint, method: "GET", parameters: nil, mapTo: MovieModel.self) { [weak self] (result: Result<MovieModel, Error>) in
            DispatchQueue.main.async {
                self?.showLoading.value = false
                switch result{
                case .success(let response):
                    self?.movieDetails.value = response
                case .failure(let error):
                    self?.error.value = error.localizedDescription
                }
            }
        }
    }
}

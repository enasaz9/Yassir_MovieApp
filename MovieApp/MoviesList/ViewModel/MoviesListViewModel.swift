//
//  MoviesListViewModel.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 25/12/2023.
//

import Foundation

protocol MoviesListViewModelInput {
    func loadData(pullToRefresh: Bool)
}

protocol MoviesListViewModelOutput {
    var moviesToBeShown: Observable<[MovieModel]> { get set }
    var showLoading: Observable<Bool> { get }
    var error: Observable<String> { get }
}

typealias MoviesListViewModelProtocols = MoviesListViewModelInput & MoviesListViewModelOutput

final class MoviesListViewModel: MoviesListViewModelProtocols {
    private let apiManager: APIManagerProtocol

    private var currentPage = 1
    private var moviesReceived: [MovieModel] = []
    private var totalPages: Int = 1
    private var totalResults: Int = 1
    
    // MARK: init

    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    // MARK: Output

    var moviesToBeShown: Observable<[MovieModel]> = Observable([])
    let showLoading: Observable<Bool> = Observable(true)
    let error: Observable<String> = Observable("")
    
    // MARK: Input
    
    func loadData(pullToRefresh: Bool) {
        if pullToRefresh {
            currentPage = 1
            moviesReceived = []
        }
        
        if currentPage <= self.totalPages {
            self.showLoading.value = true
            
            let parameters = [URLQueryItem(name: "page", value: "\(currentPage)")]
            
            apiManager.request(endpoint: API_Endpoints.moviesList.rawValue, method: "GET", parameters: parameters, mapTo: MoviesListModel.self) { [weak self] (result: Result<MoviesListModel, Error>) in
                DispatchQueue.main.async {
                    self?.showLoading.value = false
                    switch result{
                    case .success(let response):
                        self?.currentPage += 1
                        self?.totalPages = response.totalPages
                        self?.totalResults = response.totalResults
                        self?.moviesReceived.append(contentsOf: response.results)
                        self?.moviesToBeShown.value = self?.moviesReceived ?? []
                    case .failure(let error):
                        self?.error.value = error.localizedDescription
                    }
                }
            }
        }
    }
}

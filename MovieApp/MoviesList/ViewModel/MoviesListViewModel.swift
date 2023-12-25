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
    var moviesToBeShown: Observable<[String]> { get set }
    var showLoading: Observable<Bool> { get }
    var error: Observable<String> { get }
}

typealias MoviesListViewModelProtocols = MoviesListViewModelInput & MoviesListViewModelOutput

final class MoviesListViewModel: MoviesListViewModelProtocols {
        
    // MARK: Output

    var moviesToBeShown: Observable<[String]> = Observable([])
    let showLoading: Observable<Bool> = Observable(true)
    let error: Observable<String> = Observable("")
    
    // MARK: Input
    
    func loadData(pullToRefresh: Bool) {
        // load data from api
    }
    
    // MARK: init

    init() { }
    
}

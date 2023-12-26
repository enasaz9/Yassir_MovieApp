//
//  MoviesListViewController.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 23/12/2023.
//

import UIKit

class MoviesListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = MoviesListViewModel()
    private var moviesList: [MovieModel] = []
    private let spinner = UIActivityIndicatorView(style: .medium)
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List"
        initialSetup()
        bind(to: viewModel)
        viewModel.loadData(pullToRefresh: true)
        setupRefreshControl()
    }
    
    private func initialSetup() {
        tableView.registerNib(MovieTableViewCell.self)
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func bind(to viewModel: MoviesListViewModel) {
        viewModel.moviesToBeShown.observe(on: self) { [weak self] movies in
            self?.moviesList = movies
            self?.tableView.reloadData()
        }
        
        viewModel.showLoading.observe(on: self) { [weak self] isLoading in
            if isLoading {
                self?.spinner.startAnimating()
            } else {
                self?.spinner.stopAnimating()
                self?.refreshControl.endRefreshing()
            }
        }
        
        viewModel.error.observe(on: self) { [weak self] error in
            if !error.isEmpty {
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refershControlSelector), for: .valueChanged)
        tableView?.refreshControl = refreshControl
    }
    
    @objc func refershControlSelector() {
        viewModel.loadData(pullToRefresh: true)
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if moviesList.count > 1, indexPath.item == moviesList.count - 1 {
            viewModel.loadData(pullToRefresh: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(MovieTableViewCell.self, at: indexPath)
        let movie = moviesList[indexPath.row]
        cell.configure(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        print(indexPath.row)
    }
}

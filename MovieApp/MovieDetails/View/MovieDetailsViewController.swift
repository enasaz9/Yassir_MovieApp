//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 27/12/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var posterImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var viewModel: MovieDetailsViewModel!
    private let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpinner()
        bind(to: viewModel)
        viewModel.loadMovieDetails()
    }
    
    private func setupSpinner() {
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func bind(to viewModel: MovieDetailsViewModel) {
        viewModel.movieDetails.observe(on: self) { [weak self] movie in
            if movie.id != 0 {
                self?.titleLabel.text = movie.title
                self?.releaseDateLabel.text = DateFormatterHelper.formateDateString(movie.releaseDate)
                self?.overviewTextView.text = movie.overview
                
                if let url = URL(string: "\(BaseURLs.images.rawValue)w500\(movie.posterPath)") {
                    self?.posterImageView.loadImage(from: url)
                }
            }
        }
        
        viewModel.showLoading.observe(on: self) { [weak self] isLoading in
            if isLoading {
                self?.spinner.startAnimating()
            } else {
                self?.spinner.stopAnimating()
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
}

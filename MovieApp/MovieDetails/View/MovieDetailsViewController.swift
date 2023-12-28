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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: MovieDetailsViewModel) {
        viewModel.selectedMovie.observe(on: self) { [weak self] movie in
            self?.titleLabel.text = movie.title
            self?.releaseDateLabel.text = movie.releaseDate
            self?.overviewTextView.text = movie.overview
            
            if let url = URL(string: "\(BaseURLs.images.rawValue)w92\(movie.posterPath)") {
                self?.posterImageView.loadImage(from: url)
            }
        }
    }
}

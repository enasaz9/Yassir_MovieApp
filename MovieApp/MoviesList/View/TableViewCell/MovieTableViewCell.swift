//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 25/12/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var posterImageView: CustomImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // draw border for each cell
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 10
    }
    
    func configure(with movie: MovieModel) {
        titleLabel.text = movie.title
        releaseDateLabel.text = DateFormatterHelper.formateDateString(movie.releaseDate)
        voteAverageLabel.text = "\(Int(movie.voteAverage))/10"
        
        if let url = URL(string: "\(BaseURLs.images.rawValue)w92\(movie.posterPath)") {
            posterImageView.loadImage(from: url)
        }
    }
}

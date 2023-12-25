//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Enas A. Zaki on 25/12/2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with movie: String) {
        titleLabel.text = movie
        releaseDateLabel.text = movie
        voteAverageLabel.text = movie
    }
}

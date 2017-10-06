//
//  MovieTableViewCell.swift
//  unit3testpart2
//
//  Created by Brian Licea on 10/6/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var posterView: UIImageView!
    @IBOutlet weak var summarLabel: UITextView!
    
    func updateViews(withMovie movie: Movie) {
        self.titleLabel.text = movie.title
        self.ratingLabel.text = "Rating: \(movie.rating)/10"
        self.summarLabel.text = "Summary: \(movie.summary)"
        self.posterView.image = movie.image
    }

}

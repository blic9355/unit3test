//
//  Movie.swift
//  unit3testpart2
//
//  Created by Brian Licea on 10/6/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    private let titleKey = "title"
    private let ratingKey = "vote_average"
    private let summaryKey = "overview"
    private let posterPathKey = "poster_path"
    
    let title: String
    let rating: Double
    let summary: String
    let posterPath: String
    var image: UIImage? = nil
    
    init?(dictionary: [String:Any]) {
        guard let title = dictionary[titleKey] as? String,
            let rating = dictionary[ratingKey] as? Double,
            let summary = dictionary[summaryKey] as? String,
            let posterPath = dictionary[posterPathKey] as? String
            else { return nil }
        
        self.title = title
        self.rating = rating
        self.summary = summary
        self.posterPath = posterPath
    }
    
}

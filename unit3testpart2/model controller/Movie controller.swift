//
//  Movie controller.swift
//  unit3testpart2
//
//  Created by Brian Licea on 10/6/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    static let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w185/")
    
    static let apiKey = "0384f546acd8c1d1e18ac49d238e4acd"
    
    static var movies: [Movie] = []
    
    static func fetchMovie(searchTerm: String, completion: @escaping() -> Void) {
        guard let baseURL = baseURL else { completion(); return }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let queryItem = URLQueryItem(name: "api_key", value: apiKey)
        let queryItem2 = URLQueryItem(name: "query", value: searchTerm)
        
        components?.queryItems = [queryItem, queryItem2]
        
        guard let url = components?.url else { completion(); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data,
                let _ = String(data: data, encoding: .utf8)
                else { completion(); return }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:Any],
                let moviesDictionary = jsonDictionary["results"] as? [[String:Any]]
                else { completion(); return }
            
            let movies = moviesDictionary.flatMap { Movie(dictionary: $0) }
            self.movies = movies
            
            completion()
            }.resume()
    }
    
    static func fetchImage(movie: Movie, completion: @escaping() -> Void) {
        guard let imageBaseURL = imageBaseURL else { completion(); return }
        
        let url = imageBaseURL.appendingPathComponent(movie.posterPath)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data,
                let image = UIImage(data: data)
                else { completion(); return }
            
            movie.image = image
            completion()
        }
        dataTask.resume()
    }
}

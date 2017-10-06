//
//  MovieTableViewController.swift
//  unit3testpart2
//
//  Created by Brian Licea on 10/6/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.prefetchDataSource = self as? UITableViewDataSourcePrefetching
        
        self.tableView.rowHeight = 525
        
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = MovieController.movies[indexPath.row]
        cell.updateViews(withMovie: movie)
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        
        MovieController.fetchMovie(searchTerm: search) {
            let _ = MovieController.movies.flatMap { MovieController.fetchImage(movie: $0, completion: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            }
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
}



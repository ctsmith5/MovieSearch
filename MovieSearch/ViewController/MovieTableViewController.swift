//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Colin Smith on 3/22/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MovieController.sharedInstance.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        
        let movie = MovieController.sharedInstance.movies[indexPath.row]
        cell.movie = movie
        return cell
    }
} // End of Class

extension MovieTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text,
            !searchText.isEmpty else {return}
        MovieController.sharedInstance.getMovies(searchTerm: searchText) { (fetchedMovies) in
            MovieController.sharedInstance.movies = fetchedMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
                MovieController.sharedInstance.movies = fetchedMovies
            }
        }
    }
}

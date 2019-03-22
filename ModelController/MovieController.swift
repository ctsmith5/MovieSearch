//
//  MovieController.swift
//  MovieSearch
//
//  Created by Colin Smith on 3/22/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit



class MovieController {
    
   static let sharedInstance = MovieController()
    
    var movies: [Movie] = []
    
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    
    
  // I need gross spacing and lines to organize thoughts. Sorry...
    func getMovies(searchTerm: String, completion: @escaping ([Movie]) -> Void){
        
        guard let url = baseURL else {completion(movies) ; return }
    
        let apiQuery = URLQueryItem(name: "api_key", value: "6e6b1cb140fbaee2fe4a98f1ec253860")
        let movieQuery = URLQueryItem(name: "query", value: "Captain+Marvel")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [apiQuery,movieQuery]
     
        
        guard let finalUrl = urlComponents?.url else {return}
        var urlRequest = URLRequest(url: finalUrl)
        
        
        urlRequest.httpMethod = "GET"
        urlRequest.httpBody = nil
        
        
        
        URLSession.shared.dataTask(with: finalUrl) { (data, _, error) in
            if let error = error {
                print(" \(error.localizedDescription) \(error) in function \(#function) ")
                completion([])
                return
            }
            
            guard let data = data else {completion([]) ; return}
            
            
            do {
                let rootDictionary = try JSONDecoder().decode([String: Movie].self, from: data)
                let fetchedMovies = rootDictionary.compactMap { $0.value }
                self.movies = fetchedMovies
                completion(fetchedMovies)
                
            }catch{
                print("could not load from dictionary \(error.localizedDescription)")
                completion([])
            }
        }.resume()
    }
    
    
    // Setting up Url for the image
    
    
    static func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        //1) Make the url
        
        guard let url = URL(string: urlString) else { completion(nil) ; return }
        //2) Make the DataTask
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(" \(error.localizedDescription) \(error) in function \(#function) ")
                completion(nil)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
    
    
    
    
}

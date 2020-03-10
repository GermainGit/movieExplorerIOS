//
//  MovieListViewController.swift
//  TP1_movie
//
//  Created by Germain Prevot on 04/03/2020.
//  Copyright © 2020 Germain Prevot. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let cellId: String = "CellID"
    let navMovieDetail = "showMovieDetail"
    
    var myMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellId)
        tableView.reloadData()
        
        let movieRequest = MovieHttpRequest(requestUrl: "/3/discover/movie")
        movieRequest.request() { data in
            if let data = data {
                if let movieList = try? JSONDecoder().decode(MovieListResponse.self, from: data) {
                    self.myMovies = movieList.transformToMovieArray() as! [Movie]
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieManager: MovieManager = MovieManager()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableViewCell
        let movie = myMovies[indexPath.item]
        
        if let url = URL(string: movie.cover) {
            movieManager.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    cell.movieImg.image = UIImage(data: data)
                }
            }
        }
        
        cell.movieTitleLabel.text = movie.title
        cell.movieDescLabel.text = movie.synops
        if let date = movie.date{
            cell.movieDateLabel.text = String(date)
        }
        
        // TODO: Create a dictionnary with key(url) => value(imgData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = myMovies[indexPath.item]
        
        self.performSegue(withIdentifier: navMovieDetail, sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == navMovieDetail, sender != nil else{
            return
        }
        
        let detailController = segue.destination as! ViewController
        detailController.movie = sender as? Movie
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

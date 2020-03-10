//
//  ViewController.swift
//  TP1_movie
//
//  Created by Germain Prevot on 03/03/2020.
//  Copyright © 2020 Germain Prevot. All rights reserved.

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var btnAnnonce: UIButton!
    @IBOutlet weak var movieCoverImg: UIImageView!
    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieSubtitleLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieCategorieLabel: UILabel!
    @IBOutlet weak var movieSynopsLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If we try to get movie detail without movie in sender so return
        
        guard let movie = movie else{
            return
        }
        
        // Get the resquestURL build with the movie.id
        
        let movieId = movie.id
        let requestUrl = "/3/movie/\(movieId)"
        let movieRequest: MovieHttpRequest = MovieHttpRequest(requestUrl: requestUrl, hasVideo: true)
                
        movieRequest.request() { data in
            print(requestUrl)
            if let data = data {
                print("CATCH DATA")
                if let movieDetail = try? JSONDecoder().decode(MovieDetailResponse.self, from: data) {
                    DispatchQueue.main.async {
                        print("CONVERT DATA")
                        // Check the properties of the movie
                        
                        self.movie = Movie(from: movieDetail)
                        
                        // Set Data after catch movie information
                        
                        self.setDetailData()
                    }
                }
            }
        }
    }
    
    func setDetailData() {
        guard let movie = movie else{
            return
        }
        if let duration = movie.duration{
            movieDurationLabel.text = "\(duration) min"
        }
        
        let movieManager: MovieManager = MovieManager()
    
        movieTitleLabel.text = movie.title
        if let subtitle = movie.subtitle{
            movieSubtitleLabel.text = subtitle
        }else{
            movieSubtitleLabel.text = ""
        }
        if let date = movie.date{
            movieDateLabel.text = String(date)
        }
        if let synops = movie.synops {
            movieSynopsLabel.text = synops
        }
        /// TODO :
        if let categories = movie.categories{
            print(categories)
            var movieCategories: [String] = []
            for categorie in categories{
                if let categorie = categorie.name{
                   movieCategories.append(categorie)
                }
            }
            movieCategorieLabel.text = movieCategories.joined(separator: "/")
        }
        
        if let url = URL(string: movie.cover) {
            movieManager.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.movieCoverImg.image = UIImage(data: data)
                }
            }
        }
        
        if let poster = movie.poster{
            if let url = URL(string: poster) {
                movieManager.getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async() {
                        self.moviePosterImg.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    // TODO : get the real trailer link
    
    @IBAction func btnAnnoncePush(_ sender: Any) {
        guard let id = movie?.id else { return }
        let movieManager: MovieManager = MovieManager()
        let movieTrailer: String = movieManager.getMovieTrailer(movieId: id)
        guard let url = URL(string: movieTrailer) else { return }
        UIApplication.shared.open(url)
        btnAnnonce.titleLabel?.textColor = UIColor.gray
    }
}


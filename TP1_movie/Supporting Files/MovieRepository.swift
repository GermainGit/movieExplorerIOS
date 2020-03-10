//
//  HttpRequest.swift
//  TP1_movie
//
//  Created by Germain Prevot on 05/03/2020.
//  Copyright © 2020 Germain Prevot. All rights reserved.
//

import Foundation


struct MovieHttpRequest {
    
    var apiKey: String? = "?api_key=d390c0f35bb0e71e51e49e61111ab639"
    let videoRequest: String = "&append_to_response=videos"
    let requestUrl: String?
    let baseUrl: URL? = URL(string:"https://api.themoviedb.org")
    let session = URLSession.shared
    var hasVideo: Bool
    
    init(requestUrl: String, hasVideo: Bool = false) {
        self.hasVideo = hasVideo
        self.requestUrl = requestUrl
    }
    
    
    // Computed data to get the entiere requestURL
    
    var completeRequest: URL? {
        guard let baseUrl = baseUrl, let requestUrl = requestUrl, let apiKey = apiKey else{
            return nil
        }
        if(hasVideo){
            return URL(string: "\(baseUrl)\(requestUrl)\(apiKey)\(videoRequest)")
        }else{
            return URL(string: "\(baseUrl)\(requestUrl)\(apiKey)")
        }
    }
    
    func request(completionHandler: @escaping ((Data?) -> Void)){
        if let url = completeRequest {
            session.dataTask(with: url, completionHandler: { (data, response, err) in
                if let data = data {
                    completionHandler(data)
                }
            }).resume()
        }
    }
}

struct MovieManager {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // TODO : Decode JSON for video trailer
    func getMovieTrailer(movieId: Int) -> String{
        
        let baseUrl: String = "https://api.themoviedb.org/3/movie/"
        let apiKey: String = "videos?api_key=d390c0f35bb0e71e51e49e61111ab639&append_to_response=videos"
        
        return "\(baseUrl)\(movieId)\(apiKey)"
    }
}


struct MovieListResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieResponse]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    func transformToMovieArray() -> [Movie?] {
        return self.results.map({ movieResponse -> Movie? in
            Movie(from: movieResponse)
        })
    }
}

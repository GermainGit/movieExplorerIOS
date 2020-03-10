//
//  Movie.swift
//  TP1_movie
//
//  Created by Germain Prevot on 04/03/2020.
//  Copyright © 2020 Germain Prevot. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let cover: String
    let poster: String?
    let title: String
    let subtitle: String?
    let synops: String?
    let duration: Int?
    let date: Int?
    let categories: [Genre]?
    let trailerUrl: String?

    init?(from movieResponse: MovieResponse) {
        guard let title = movieResponse.title,
            let cover = movieResponse.backdropPath,
            let id = movieResponse.id
            else { return nil }
        self.id = id
        self.title = title
        self.date = Int(String(movieResponse.releaseDate!.prefix(4))) ?? 1
        self.synops = movieResponse.overview
        self.cover = "https://image.tmdb.org/t/p/w300" + cover
        self.categories = []
        self.trailerUrl = nil
        self.subtitle = nil
        self.poster = nil
        self.duration = nil
    }
    
    init?(from movieDetailResponse: MovieDetailResponse) {
        guard let title = movieDetailResponse.title,
            let cover = movieDetailResponse.backdropPath,
            let id = movieDetailResponse.id
            else { return nil }
        self.id = id
        self.title = title
        self.date = Int(String(movieDetailResponse.releaseDate!.prefix(4))) ?? 1
        self.synops = movieDetailResponse.overview
        self.cover = "https://image.tmdb.org/t/p/w300" + cover
        self.categories = movieDetailResponse.genres
        self.trailerUrl = nil
        self.subtitle = movieDetailResponse.tagline
        if let poster = movieDetailResponse.posterPath {
            self.poster = "https://image.tmdb.org/t/p/w300" + poster
        }else{
            self.poster = nil
        }
        self.duration = movieDetailResponse.runtime
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MovieDetailResponse: Codable {
    let backdropPath: String?
    let genres: [Genre]?
    let id: Int?
    let originalTitle, overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String?
    let tagline: String?
    let videos: VideoList?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title, tagline
        case videos
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct VideoList: Codable {
    let results: [Video]?
}

struct Video: Codable {
    let key: String?
    let id: Int?
}


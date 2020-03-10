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
    let results: [Video]
    
    func getTrailers(targetSite: String = "youtube") -> [Video] {
        return results.filter { (movieVideo) in
            movieVideo.type.lowercased() == "trailer" && movieVideo.site.lowercased() == targetSite
        }
    }
    
    func getLastTrailer() -> Video? {
        let trailers = self.getTrailers()
        guard let lastTrailer = trailers.last else {
            return nil
        }
        
        return lastTrailer
    }
}

struct Video: Codable {
    let id, key: String
    let name, site: String
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case key, name, site, size, type
    }
    
    func getYoutubeLink() -> URL? {
        let ytUrl = "https://www.youtube.com/watch?v=\(key)"
    
        return URL(string: ytUrl)
    }
}


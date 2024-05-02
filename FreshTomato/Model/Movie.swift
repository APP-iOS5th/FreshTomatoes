//
//  Movie.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

struct MovieDetail {
    let title: String
    let posterName: String
    let year: String
    let genre: String
    let runningtime: String
    let rating: Double
    let description: String
    
    init(title: String, posterName: String, year: String, genre: String, runningtime: String, rating: Double, description: String) {
        self.title = title
        self.posterName = posterName
        self.year = year
        self.genre = genre
        self.runningtime = runningtime
        self.rating = rating
        self.description = description
    }
}

let moviedetails = [
    MovieDetail(title: "Sponge", posterName: "sponge", year: "2024", genre: "cartoon", runningtime: "20min", rating: 8.8, description: "Inception is a science fiction action film directed by Christopher Nolan."),
    MovieDetail(title: "Scream Sponge", posterName: "wakesponge", year: "2024", genre: "movie", runningtime: "120min", rating: 8.8, description: "Inception is a science fiction action film directed by Christopher Nolan."),
    MovieDetail(title: "GamJa", posterName: "potato2", year: "2024", genre: "movie", runningtime: "120min", rating: 8.8, description: "Inception is a science fiction action film directed by Christopher Nolan.")
]


struct MovieResponse: Codable {
    let dates: Dates
    let page: Int
    let results: [Movie]
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview
            case popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title
            case video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
}


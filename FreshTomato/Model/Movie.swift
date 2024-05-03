//
//  Movie.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

//struct MovieResponse: Codable {
//    let dates: Dates
//    let page: Int
//    let results: [Movie]
//}
//
//struct Dates: Codable {
//    let maximum: String
//    let minimum: String
//}
//
//struct Movie: Codable {
//    let adult: Bool
//    let backdropPath: String?
//    let genreIds: [Int]
//    let id: Int
//    let originalLanguage: String
//    let originalTitle: String
//    let overview: String
//    let popularity: Double
//    let posterPath: String?
//    let releaseDate: String
//    let title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//            case adult
//            case backdropPath = "backdrop_path"
//            case genreIds = "genre_ids"
//            case id
//            case originalLanguage = "original_language"
//            case originalTitle = "original_title"
//            case overview
//            case popularity
//            case posterPath = "poster_path"
//            case releaseDate = "release_date"
//            case title
//            case video
//            case voteAverage = "vote_average"
//            case voteCount = "vote_count"
//        }
//}

// MARK: - API 통신으로 데이터 가져와서 저장하는 구조체
struct Movie: Identifiable, Codable, Hashable{
    let id: Int
    let title: String
    let backdrop_path: String?
    let poster_path: String?
    let overview: String
    let genre_ids: [Int]
    let vote_average: Double
    
    var backdropURL: URL? {
        guard let backdropPath = backdrop_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
    
    var posterURL: URL? {
        guard let posterPath = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}


struct MovieResponse: Codable {
    let results: [Movie]
}

//MARK: - FilterView에서 사용할 영화 장르 열거형으로 정의
enum MovieGenre: Int, CaseIterable, Codable {
    case action = 28, adventure = 12, animation = 16, comedy = 35, crime = 80, documentary = 99, drama = 18,
         family = 10751, fantasy = 14, history = 36, horror = 27, music = 10402, mystery = 9648,
         romance = 10749, scienceFiction = 878, thriller = 53, tvMovie = 10770, war = 10752, western = 37

    var description: String {
        switch self {
        case .action: return "Action"
        case .adventure: return "Adventure"
        case .animation: return "Animation"
        case .comedy: return "Comedy"
        case .crime: return "Crime"
        case .documentary: return "Documentary"
        case .drama: return "Drama"
        case .family: return "Family"
        case .fantasy: return "Fantasy"
        case .history: return "History"
        case .horror: return "Horror"
        case .music: return "Music"
        case .mystery: return "Mystery"
        case .romance: return "Romance"
        case .scienceFiction: return "Science Fiction"
        case .thriller: return "Thriller"
        case .tvMovie: return "TV Movie"
        case .war: return "War"
        case .western: return "Western"
        }
    }
}

//MARK: - API 에서 가져온 영화 데이터 중에서 장르 비교해서 같은 장르인거 필터하기위해 추가
extension Movie  {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

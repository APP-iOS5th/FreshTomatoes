//
//  Movie.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let popularity: Double
    let release_date: String
    let poster_path: String
    let vote_average: Double
    
    
    
    // 다른 필요한 속성들을 추가할 수 있습니다.
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}
//
//func getNowPlayingMovies() async throws -> MoviesResponse {
//    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
//    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//    let queryItems: [URLQueryItem] = [
//        URLQueryItem(name: "language", value: "en-US"),
//        URLQueryItem(name: "page", value: "1"),
//    ]
//    components.queryItems = (components.queryItems ?? []) + queryItems
//    
//    var request = URLRequest(url: components.url!)
//    request.httpMethod = "GET"
//    request.timeoutInterval = 10
//    request.allHTTPHeaderFields = ["accept": "application/json"]
//    
//    let (data, _) = try await URLSession.shared.data(for: request)
//    return try JSONDecoder().decode(MoviesResponse.self, from: data)
//}

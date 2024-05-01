//
//  MovieService.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//
import Foundation

protocol MovieService {
    
}

enum MovieListEndpoint: String {
    case boxoffice
    case upcoming
    case TopRated
    case pupular
    
    var description: String {
        switch self {
        case .boxoffice: return "Box Office"
        case .upcoming: return "Upcoming"
        case .TopRated: return "Top Rated"
        case.pupular: return "Popular"
        }
    }
}

enum MovieErrer: Error {
    case apiErrer
    case invalidEndpoing
    case invalidResponse
    case noData
    case serializationError
}

func fetchNowPlayingMovies() async {
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    let queryItems: [URLQueryItem] = [
        URLQueryItem(name: "language", value: "en-US"),
        URLQueryItem(name: "page", value: "1"),
    ]
    components.queryItems = (components.queryItems ?? []) + queryItems
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.allHTTPHeaderFields = ["accept": "application/json"]
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
    } catch {
        print(error)
    }
}


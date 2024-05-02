//
//  MovieService.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//
import Foundation

protocol MovieService {
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MoviesResponse, MovieError>) -> ())
        func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
        func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, MovieError>) -> ())
    }

enum MovieListEndpoint: String {
    case boxoffice = "now_playing"
    case upcoming
    case TopRated = "top_rated"
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

enum MovieError: Error {
    case apiError
    case invalidEndpoing
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoing: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}



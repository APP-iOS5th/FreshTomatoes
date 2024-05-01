//
//  MovieStore.swift
//  FreshTomato
//
//  Created by 김형준 on 5/1/24.
//

import Foundation

class MovieStore: MovieService {
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "APIKEY"
    private let baseAPIURL = "https://api.themoviedb.org/3/movie"
    private let rulSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoing))
        }
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        <#code#>
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MoviesResponse, MovieError>) -> ()) {
        
    }
    
    private func loadURLAndDecode<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()){
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoing))
            return
        }
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = queryItems
        
    }
    
   
}

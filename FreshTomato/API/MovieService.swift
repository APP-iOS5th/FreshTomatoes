//
//  MovieService.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation
import SwiftUI



class MovieService {
    
    enum boxOfficeStatus: String {
        case nowPlaying = "now_playing"
        case upComing = "upcoming"
        case rank = "top_rated"
    }

    static let shared = MovieService()
    private let apiKey = "7f20d823d0156ecf01791f1da2f595d1"
    
//    private init() {}

    
    func fetchNowPlayingMovies(boxOfficeStatus: boxOfficeStatus, language: String, page: Int, region: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(boxOfficeStatus.rawValue)?api_key=\(apiKey)&language=\(language)&page=\(page)&region=\(region)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer ACCESS_TOKEN", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchMultiplePages(pages: [Int], language: String, region: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var allMovies: [Movie] = []
        var anyError: Error?

        for page in pages {
            dispatchGroup.enter()
            fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: language, page: page, region: region) { result in
                switch result {
                case .success(let movies):
                    allMovies.append(contentsOf: movies)
                case .failure(let error):
                    anyError = error
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            if let error = anyError {
                completion(.failure(error))
            } else {
                let uniqueMovies = Set(allMovies).sorted(by: { $0.id < $1.id }) // Remove duplicates and sort by id
                completion(.success(Array(uniqueMovies)))
            }
        }
    }
}


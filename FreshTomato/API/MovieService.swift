//
//  MovieService.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

@MainActor
class MovieService: ObservableObject {
    @Published var movies = [Movie]()
    
    let url = movieAPI
    
    func loadMovie() async {
        guard let url = URL(string: movieAPI) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
//            print("meta : \(meta)")
            guard let decodeResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) else {
                print("decodeResponse Error")
                return
            }
            movies = decodeResponse.results
//            print(movies)
        }catch {
            print("Invalid data")
        }
    }
    
    
    // TMDB 권장 Get
    enum boxOfficeStatus: String {
        case nowPlaying = "now_playing"
        case upComing = "upcoming"
        case rank = "top_rated"
    }
    
    func load(boxOfficeStatus: boxOfficeStatus) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(boxOfficeStatus.rawValue)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "ko-KR"),
          URLQueryItem(name: "page", value: "1"),
          URLQueryItem(name: "region", value: "KR"),
          URLQueryItem(name: "api_key", value: apiKey),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMDkyMTlmNjg2NmFkMTBmNWZmZTkwMTFhZDRhZmFkYiIsInN1YiI6IjY2MmZhN2UxOGE4OGIyMDEyN2NlZDFjZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sIGK-E0EfADoQWLDscReig-ExB8g2LLchGRH6AGVtRs"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
        } catch {
            
        }
    }

}


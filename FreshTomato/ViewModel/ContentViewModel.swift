//
//  ContentViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation
import Combine

class NowPlayingMoviesViewModel: ObservableObject {
    @Published var nowplayingmovies: [Movie] = []
    
    private var cancellable: AnyCancellable?
    
    init()  {
        fetchMovies()
    }
    
    func fetchMovies() {
        let baseURL = "https://api.themoviedb.org/3/movie/now_playing"
        let urlString = "\(baseURL)?language=ko-KR&page=1"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        let queryItems: [URLQueryItem] = [
//          URLQueryItem(name: "language", value: "en-US"),
//          URLQueryItem(name: "page", value: "1"),
//        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5Njg0MTY5OTc0ZGRjYWYzZjJjZmY2MmJkNGI0ODQ4MyIsInN1YiI6IjY2MzIwNDIxOTU5MGUzMDEyY2JhMjlhZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XQRtPeQ8pgvCLyYlFz8Nzhw91mNw1-CVqKacZ9Rdh84"
        ]
        
//        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        //
        //        let parameters: [String: String] = [
        //            "api_key": accessToken
        //        ]
        //
        //        guard let apiUrl = URL(string: url) else { return }
        //
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
                    .map{$0.data}
                    .decode(type: MoviesResponse.self, decoder: JSONDecoder())
                    .map{$0.results}
                    .replaceError(with: [])
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.nowplayingmovies, on: self)
              
        
       
      

       
//        let (data, _) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
        
        
        
    }
}


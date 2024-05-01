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
    
}

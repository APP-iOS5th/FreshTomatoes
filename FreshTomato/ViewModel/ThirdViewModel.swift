//
//  ThirdViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

class ThirdViewModel: ObservableObject {
    @Published var searchMovies: [Movie] = []
    
    func fetchSearchResults(query: String) {
        MovieService.shared.searchMovies(query: query, language: "ko-KR", page: 1, region: "ko-KR") { results in
            switch results {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = Set(movies)
                    self.searchMovies = Array(uniqueMovies)
                    print("search \(self.searchMovies)")
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
            }
        }
    }
}

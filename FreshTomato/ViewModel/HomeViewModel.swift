//
//  HomeViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

class HomeViewModel: ObservableObject {
  
    
//    @Published var isLoading = false
    @Published var movies: [Movie] = []
    @Published var upComingMovies: [Movie] = []
//    @Published var allMovies: [Movie] = []
  
    // 상영작 가져오기~
    func fetchNowPlayingMovies(pages:Int) {
//        isLoading = true
        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
//                    var uniqueMovies = Set<Movie>()
                    var uniqueMovies = [Movie]()
                    movies.forEach { uniqueMovies.append($0) }

                    self.movies.removeAll()
                    
                    self.movies = Array(uniqueMovies)
                    
//                    self.isLoading = false
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
//                self.isLoading = false
            }
        }
    }
    
    // 개봉 예정작 가져오기~
    func fetchUpComingMovies(pages:Int) {
//        isLoading = true
        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .upComing, language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = [Movie]()
                    movies.forEach { uniqueMovies.append($0) }
                    
                    self.upComingMovies.removeAll()
                    
                    self.upComingMovies = Array(uniqueMovies)
                    
//                    self.isLoading = false
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
//                self.isLoading = false
            }
        }
    }
}

//
//  HomeViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
  
    //MARK: - Movie 에서 가져온 장르 번호 바탕으로 필터 하는 함수
    func fetchNowPlayingMovies(pages:Int) {
        isLoading = true
        MovieService.shared.fetchNowPlayingMovies(language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = Set<Movie>()
                    movies.forEach { uniqueMovies.insert($0) }
                    
                    self.movies.removeAll()
                    
                    self.movies = Array(uniqueMovies)
                    
                    self.isLoading = false
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
                self.isLoading = false
            }
        }
    }
    
}

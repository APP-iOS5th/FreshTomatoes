//
//  HomeViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var upComingMovies: [Movie] = []
    @Published var allMovies: [Movie] = []
  
    func fetchNowPlayingMovies() {
        let pages = [1,2,3,4,5]
        var allMovies = [Movie]()
        let group = DispatchGroup()
        
        for page in pages {
            group.enter()
            MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: "ko-KR", page: page, region: "KR") { result in
                defer { group.leave() }
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        allMovies.append(contentsOf: movies)
                    }
                case .failure(let error):
                    print("Error fetching page \(page): \(error)")
                }
            }
        }
        
        group.notify(queue: .main) {
            let uniqueMovies = Set(allMovies).sorted(by: { $0.id < $1.id })
            self.movies = Array(uniqueMovies)
        }
    }
    
    func fetchUpComingMovies() {
        let pages = [1,2]
        var allMovies = [Movie]()
        let group = DispatchGroup()
        
        for page in pages {
            group.enter()
            MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .upComing, language: "ko-KR", page: page, region: "KR") { result in
                defer { group.leave() }
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        allMovies.append(contentsOf: movies)
                    }
                case .failure(let error):
                    print("Error fetching page \(page): \(error)")
                }
            }
        }
        
        group.notify(queue: .main) {
            let uniqueMovies = Set(allMovies).sorted(by: { $0.id < $1.id })
            self.upComingMovies = Array(Set(allMovies))
        }
    }
    
    func fetchTopRankMovies() {
        let pages = [1,2,3,4,5,6,7,8,9,10]
        var allMovies = [Movie]()
        let group = DispatchGroup()
        
        for page in pages {
            group.enter()
            MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .rank, language: "ko-KR", page: page, region: "KR") { result in
                defer { group.leave() }
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        allMovies.append(contentsOf: movies)
                    }
                case .failure(let error):
                    print("Error fetching page \(page): \(error)")
                }
            }
        }
        
        group.notify(queue: .main) {
            let uniqueMovies = Set(allMovies).sorted(by: { $0.id < $1.id })
            self.allMovies = Array(Set(allMovies))
        }
    }
    
}

//
//  HomeViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // UserDefaults
//    let userDefaults = UserDefaults.standard
//    @Published var storageMovies: [Movie] = []
//
//    func setStorage(movie: Movie) {
//        print("저장 시작")
//        self.storageMovies = getStorage()
//        self.storageMovies.append(movie)
//
//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(self.storageMovies)
//            UserDefaults.standard.set(data, forKey: "storageMovies")
//            print("저장 끝")
//        } catch {
//            print("Error encoding storageMovies: \(error)")
//        }
//    }
//
//    func getStorage() -> [Movie] {
//        print("다운 시작")
//        if let data = UserDefaults.standard.data(forKey: "storageMovies") {
//            do {
//                let decoder = JSONDecoder()
//                print("다운 끝")
//                self.storageMovies = try decoder.decode([Movie].self, from: data)
//                return try decoder.decode([Movie].self, from: data)
//            } catch {
//                print("Error decoding storageMovies: \(error)")
//            }
//        }
//        return []
//    }

    
    
//    @Published var isLoading = false
    @Published var movies: [Movie] = []
    @Published var upComingMovies: [Movie] = []
    @Published var allMovies: [Movie] = []
  
    // 상영작 가져오기~
//    func fetchNowPlayingMovies(pages:Int) {
//        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: "ko-KR", page: pages, region: "KR") { result in
//            switch result {
//            case .success(let movies):
//                DispatchQueue.main.async {
////                    var uniqueMovies = [Movie]()
////                    movies.forEach { uniqueMovies.append($0) }
//                    var uniqueMovies = Set<Movie>()
//                    movies.forEach { uniqueMovies.insert($0) }
//
//                    self.movies.removeAll()
//                    
//                    self.movies = Array(uniqueMovies)
//                }
//            case .failure(let error):
//                print("Failed to fetch movies: \(error)")
//            }
//        }
//    }
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
    
    // 개봉 예정작 가져오기~
//    func fetchUpComingMovies(pages:Int) {
//        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .upComing, language: "ko-KR", page: pages, region: "KR") { result in
//            switch result {
//            case .success(let movies):
//                DispatchQueue.main.async {
////                    var uniqueMovies = [Movie]()
////                    movies.forEach { uniqueMovies.append($0) }
//                    var uniqueMovies = Set<Movie>()
//                    movies.forEach { uniqueMovies.insert($0) }
//                    
//                    self.upComingMovies.removeAll()
//                    
//                    self.upComingMovies = Array(uniqueMovies)
//                }
//            case .failure(let error):
//                print("Failed to fetch movies: \(error)")
//            }
//        }
//    }
    
//    // 탑 랭크 영화 가져오기~
//    func fetchTopRankMovies(pages:Int) {
//        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .rank, language: "ko-KR", page: pages, region: "KR") { result in
//            switch result {
//            case .success(let movies):
//                DispatchQueue.main.async {
////                    var uniqueMovies = [Movie]()
////                    movies.forEach { uniqueMovies.append($0) }
//                    var uniqueMovies = Set<Movie>()
//                    movies.forEach { uniqueMovies.insert($0) }
//                    
//                    self.topRankMovies.removeAll()
//                    
//                    self.topRankMovies = Array(uniqueMovies)
//                }
//            case .failure(let error):
//                print("Failed to fetch movies: \(error)")
//            }
//        }
//    }
}

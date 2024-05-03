//
//  HomeViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

//extension UserDefaults {
//    func set<T: Codable>(_ value: T, forKey key: String) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(value) {
//            self.set(encoded, forKey: key)
//        }
//    }
//
//    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
//        guard let data = self.data(forKey: key) else { return nil }
//        let decoder = JSONDecoder()
//        return try? decoder.decode(type, from: data)
//    }
//    
//    // 수정된 함수
//    func get<T: Codable>(_ type: [T].Type, forKey key: String) -> [T]? {
//        guard let data = self.data(forKey: key) else { return nil }
//        let decoder = JSONDecoder()
//        return try? decoder.decode([T].self, from: data)
//    }
//}

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    
    @Published var upComingMoives: [Movie] = []
    
    // UserDefaults
    let userDefaults = UserDefaults.standard
    @Published var storageMovies: [Movie] = []
    
    func setStorage(movie: Movie) {
        print("저장 시작")
        self.storageMovies = getStorage()
        self.storageMovies.append(movie)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.storageMovies)
            UserDefaults.standard.set(data, forKey: "storageMovies")
            print("저장 끝")
        } catch {
            print("Error encoding storageMovies: \(error)")
        }
    }
    
    func getStorage() -> [Movie] {
        print("다운 시작")
        if let data = UserDefaults.standard.data(forKey: "storageMovies") {
            do {
                let decoder = JSONDecoder()
                print("다운 끝")
                self.storageMovies = try decoder.decode([Movie].self, from: data)
                return try decoder.decode([Movie].self, from: data)
            } catch {
                print("Error decoding storageMovies: \(error)")
            }
        }
        return []
    }
    
//    func setStorage(movie: Movie) {
//        print("저장 시작")
//        storageMovies.append(movie)
////        userDefaults.set(storageMovies, forKey: "storageMovies")
//        print("\(storageMovies) 저장 완료.")
//    }
//    
//    func getStorage() {
//        print("불러오기 시작. \(self.storageMovies)")
//        if let getMovies: [Movie] = userDefaults.get([Movie].self, forKey: "storageMovies") {
//            self.storageMovies = getMovies
//            print("불러옴. \(self.storageMovies)")
//        }
//    }
    
    
  
    func fetchNowPlayingMovies(pages:Int) {
//        isLoading = true
        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = Set<Movie>()
                    movies.forEach { uniqueMovies.insert($0) }
                    
                    
                    
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
    
    func fetchUpComingMovies(pages:Int) {
//        isLoading = true
        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .upComing, language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = Set<Movie>()
                    movies.forEach { uniqueMovies.insert($0) }
                    
                    self.upComingMoives.removeAll()
                    
                    self.upComingMoives = Array(uniqueMovies)
                    
//                    self.isLoading = false
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
//                self.isLoading = false
            }
        }
    }
}

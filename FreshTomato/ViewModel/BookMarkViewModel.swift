//
//  BookMarkViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 5/3/24.
//

import Foundation
class BookmarkViewModel: ObservableObject {
    
    // UserDefaults
    let userDefaults = UserDefaults.standard
    @Published var storageMovies = Set<Movie>()
    
    func setStorage(movie: Movie) {
        print("저장 시작")
        self.storageMovies = getStorage()
        self.storageMovies.insert(movie)
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self.storageMovies)
            UserDefaults.standard.set(data, forKey: "storageMovies")
            print("저장 끝")
        } catch {
            print("Error encoding storageMovies: \(error)")
        }
    }
    
    func getStorage() -> Set<Movie> {
        print("다운 시작")
        if let data = UserDefaults.standard.data(forKey: "storageMovies") {
            do {
                let decoder = JSONDecoder()
                print("다운 끝")
                self.storageMovies = try decoder.decode(Set<Movie>.self, from: data)
                return try decoder.decode(Set<Movie>.self, from: data)
            } catch {
                print("Error decoding storageMovies: \(error)")
            }
        }
        return []
    }
    

    
    
    
}

//
//  MyMovie.swift
//  FreshTomato
//
//  Created by Jude Song on 5/2/24.
//

//import Foundation
//
//struct MyMovie: Identifiable, Codable, Hashable {
//    var id: Int
//    var title: String
//    var backdrop_path: String?
//    var overview: String
//    let genre_ids: [Int]
//    let genre_names: String
//    
//    var backdropURL: URL? {
//        guard let backdropPath = backdrop_path else { return nil }
//        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
//    }
//}
//
//struct MovieResponse: Codable {
//    let results: [MyMovie]
//}
//

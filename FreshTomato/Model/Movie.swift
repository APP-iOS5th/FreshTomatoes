//
//  Movie.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let popularity: Double
    let release_date: String
    let poster_path: String
    let vote_average: Double
    // 다른 필요한 속성들을 추가할 수 있습니다.
}

struct MoviesResponse: Decodable {
    let results: [Movie]
}






//
//  test.swift
//  FreshTomato
//
//  Created by 김형준 on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []
    
    var body: some View {
        List(movies, id: \.id) { movie in
            Text(movie.title)
        }
        .onAppear {
            fetchNowPlayingMovies()
        }
    }
    
    func fetchNowPlayingMovies() {
        Task {
            do {
                let moviesData = try await getNowPlayingMovies()
                movies = moviesData.results
            } catch {
                print(error)
            }
        }
    }
    
}

#Preview {
    ContentView()
}

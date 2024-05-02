//
//  test.swift
//  FreshTomato
//
//  Created by 김형준 on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieViewModel = NowPlayingMoviesViewModel()
    
    var body: some View {
        NavigationView {
            List(movieViewModel.nowplayingmovies) { movie in
                Text(movie.title)
            }
            .navigationTitle("Movies")
        }
    }
}


#Preview {
    ContentView()
}

//
//  HomeView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var movieService: MovieService = MovieService()
    
    @State var currentMovie: [String] = []
    @State var offset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                        VStack {
                            TitleView(semiTitle: "Fresh Tomatoes", title: "NOW SHOWING", buttonTitle: "View all")
                                .padding(.horizontal)
                            ZStack {
                                Image("cinemaImage")
                                    .resizable()
                                    .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                                    .overlay {
                                        LinearGradient(colors: [.white, .clear, .clear, .clear, .white], startPoint: .top, endPoint: .bottom)
                                    }
                                ScrollViewReader { proxy in
                                                // 영화 Card ScrollView
                                                ScrollView(.horizontal) {
                                                    HStack(spacing: geometry.size.width * 0.07) {
                                                        ForEach(Array(movieService.movies.enumerated()), id: \.element.id) { cardIndex, movie in
                                                            NavigationLink(destination: MoviDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)) {
                                                                NowShowingCardView(recWidth: geometry.size.width * 0.6, recHeight: geometry.size.height * 0.5, movie: movie)
                                                                    .containerRelativeFrame(.horizontal, count: 2, spacing: -30)
                                                                    .scrollTransition { view, phase in
                                                                        return view
                                                                            .opacity(phase.isIdentity ? 1.0 : 0.4)
                                                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                                                    }
                                                                    .foregroundStyle(.black)
                                                            }
                                                        }
                                                    }
                                                    .padding(.horizontal, geometry.size.width * 0.232)
                                                    .padding(.vertical)
                                                    .scrollTargetLayout()
                                                }
                                                .scrollIndicators(.hidden)
                                                .scrollTargetBehavior(.viewAligned)
                                }
                            }
                            
                            TitleView(semiTitle: "", title: "UP COMING", buttonTitle: "View all")
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(movieService.movies, id: \.id) { movie in
                                        NavigationLink(destination: MoviDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)){
                                            MovieCard(movie: movie, recWidth: geometry.size.width * 0.37, recHeight: geometry.size.height * 0.3, imageType: "Poster")
                                        }
                                    }
                                }
                                .padding(.horizontal, geometry.size.width * 0.045)
                            }
                            .scrollIndicators(.hidden)
                            
                            TitleView(semiTitle: "", title: "OVERALL MOVIE RANKING", buttonTitle: "View all")
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(movieService.movies, id: \.id) { movie in
                                        NavigationLink(destination: MoviDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)){
                                            MovieCard(movie: movie, recWidth: geometry.size.width * 0.37, recHeight: geometry.size.height * 0.13, imageType: "Background")
                                        }
                                    }
                                }
                                .padding(.horizontal, geometry.size.width * 0.045)
                            }
                            .scrollIndicators(.hidden)
                            Spacer()
                        }
                        .padding(.vertical)
                    
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await movieService.loadMovie()
//            await movieService.load(boxOfficeStatus: .nowPlaying)
//            await movieService.load(boxOfficeStatus: .upComing)
//            await movieService.load(boxOfficeStatus: .rank)
            currentMovie = movieService.movies.map{ $0.backdropPath ?? "" }
        }
    }
    
    
    
}

#Preview {
    HomeView()
}

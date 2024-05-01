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
    @Namespace var scrollIndex
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                        VStack {
                            TitleView(semiTitle: "Fresh Tomatoes", title: "NOW SHOWING", buttonTitle: "View all")
                                .padding(.horizontal)
                            
                            
                            //배경을 foreach로 생성하고 scrollview index를 넣어, 영화 card의 scroll index가 변할때 (배경index = 영화index)로 맞추어 배경 scroll을 자동으로 넘겨버리기..?
                            ZStack {
                                // 배경 ScrollView
                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(currentMovie, id: \.self) { backImage in
                                            BackgroundImageView(backImage: backImage, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.6)
                                        }
                                    }
                                }
                                // 영화 Card ScrollView
                                ScrollView(.horizontal) {
                                    HStack(spacing: geometry.size.width * 0.07) {
                                        ForEach(Array(movieService.movies.enumerated()), id: \.element.id) { index, movie in
                                            NowShowingCardView(recWidth: geometry.size.width * 0.6, recHeight: geometry.size.height * 0.5, movie: movie)
                                                .containerRelativeFrame(.horizontal, count: 2, spacing: -30)
                                                .scrollTransition { view, phase in
                                                    return view
                                                        .opacity(phase.isIdentity ? 1.0 : 0.4)
                                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
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
                            
                            
                            TitleView(semiTitle: "", title: "UP COMING", buttonTitle: "View all")
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(movieService.movies, id: \.id) { movie in
                                        MovieCard(movie: movie, recWidth: geometry.size.width * 0.37, recHeight: geometry.size.height * 0.3, imageType: "Poster")
                                    }
                                }
                                .padding(.horizontal, geometry.size.width * 0.045)
                            }
                            .scrollIndicators(.hidden)
                            
                            TitleView(semiTitle: "", title: "MOVIE RANK", buttonTitle: "View all")
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(movieService.movies, id: \.id) { movie in
                                        MovieCard(movie: movie, recWidth: geometry.size.width * 0.37, recHeight: geometry.size.height * 0.13, imageType: "Background")
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
            currentMovie = movieService.movies.map{ $0.backdropPath ?? "" }
        }
    }
    
    
    
}

#Preview {
    HomeView()
}

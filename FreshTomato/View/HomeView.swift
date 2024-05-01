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
    
    @State var currentMovie: String = ""
    @Namespace var scrollIndex
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    ZStack(alignment: .top) {
                        ZStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(currentMovie)")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width)
                                    .overlay {
                                        LinearGradient(colors: [.white, .clear, .clear, .white], startPoint: .top, endPoint: .bottom)
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .padding(.top, geometry.size.height * 0.03)
                        }
                        VStack {
                            TitleView(semiTitle: "Fresh Tomatoes", title: "NOW SHOWING", buttonTitle: "View all")
                            .padding(.horizontal)
                            
//                            foreach로 nowshowingcardview 생성하면서 뒤에 배경까지 같이 생성?!
                                ScrollView(.horizontal) {
                                        HStack(spacing: geometry.size.width * 0.07) {
                                            ForEach(Array(movieService.movies.enumerated()), id: \.element.id) { index, movie in
                                                NowShowingCardView(recWidth: geometry.size.width * 0.6, recHeight: geometry.size.height * 0.5, movie: movie)
                                                    .containerRelativeFrame(.horizontal, count: 2, spacing: -70)
                                                    .scrollTransition { view, phase in
                                                        return view
                                                            .opacity(phase.isIdentity ? 1.0 : 0.4)
                                                            .scaleEffect(phase.isIdentity ? 1.0 : 0.6)
                                                    }
                                            }
                                        }
                                        .padding(geometry.size.width * 0.05)
                                    .scrollTargetLayout()
                                }
                                .scrollIndicators(.hidden)
                                .scrollTargetBehavior(.viewAligned)
                            
                            
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
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await movieService.loadMovie()
        }
    }
    
    
    
}

#Preview {
    HomeView()
}

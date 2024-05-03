//
//  HomeView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @Binding var currentTab: Tab
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack {
                        TitleView(currentTab: $currentTab, semiTitle: "Fresh Tomatoes", title: "NOW SHOWING", buttonTitle: "View all", movies: homeVM.movies, allViewImageWidth: geometry.size.width * 0.27, allViewImageHeight: geometry.size.height * 0.21, detailViewWidth: geometry.size.width, detailViewHeight: geometry.size.height * 0.4)
                            .padding(.horizontal)
                        ZStack {
                            Image("cinemaImage")
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.6)
                                .overlay {
                                    LinearGradient(colors: [.white, .clear, .clear, .clear, .white], startPoint: .top, endPoint: .bottom)
                                }
                            
                            // 영화 Card ScrollView
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: geometry.size.width * 0.07) {
                                    ForEach(homeVM.movies.prefix(15), id: \.id) {  movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)) {
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
                        
                        TitleView(currentTab: $currentTab, semiTitle: "", title: "UP COMING", buttonTitle: "View all", movies: homeVM.upComingMovies, allViewImageWidth: geometry.size.width * 0.27, allViewImageHeight: geometry.size.height * 0.21, detailViewWidth: geometry.size.width, detailViewHeight: geometry.size.height * 0.4)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(homeVM.upComingMovies.prefix(15), id: \.id) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)){
                                        MovieCard(movie: movie, recWidth: geometry.size.width * 0.37, recHeight: geometry.size.height * 0.3, imageType: "Poster")
                                    }
                                }
                            }
                            .padding(.horizontal, geometry.size.width * 0.045)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.32)
                        .scrollIndicators(.hidden)
                        
                        TitleView(currentTab: $currentTab, semiTitle: "", title: "ALL MOVIE", buttonTitle: "View all", movies: homeVM.allMovies, allViewImageWidth: geometry.size.width * 0.27, allViewImageHeight: geometry.size.height * 0.21, detailViewWidth: geometry.size.width, detailViewHeight: geometry.size.height * 0.4)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(homeVM.allMovies.prefix(15), id: \.id) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)){
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
        .onAppear {
            homeVM.fetchNowPlayingMovies()
            homeVM.fetchUpComingMovies()
            homeVM.fetchTopRankMovies()
        }
    }
    
    
    
}


//#Preview {
//    HomeView()
//}

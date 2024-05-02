//
//  HomeView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    //    @StateObject var movieService: MovieService = MovieService()
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    
    @State var movies: [Movie] = []
    
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
                            // 영화 Card ScrollView
                            ScrollView(.horizontal) {
                                HStack(spacing: geometry.size.width * 0.07) {
                                    ForEach(homeVM.movies, id: \.id) {  movie in
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
                        
                        TitleView(semiTitle: "", title: "UP COMING", buttonTitle: "View all")
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(homeVM.movies, id: \.id) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie, imageWidth: geometry.size.width, imageHeight: geometry.size.height * 0.4)){
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
                                ForEach(homeVM.movies, id: \.id) { movie in
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
        .task {
            homeVM.fetchNowPlayingMovies(pages: 1)
            //            await movieService.loadMovie()
            //            await movieService.load(boxOfficeStatus: .nowPlaying)
            //            await movieService.load(boxOfficeStatus: .upComing)
            //            await movieService.load(boxOfficeStatus: .rank)
            //            currentMovie = movieService.movies.map{ $0.backdropPath ?? "" }
        }
    }
    
    
    
}

//#Preview {
//    HomeView()
//}


//struct MoviDetailView: View {
//    var movie: Movie
//
//    var imageWidth: CGFloat
//    var imageHeight: CGFloat
//
//    var body: some View {
//        VStack(spacing: 0) {
//            ZStack(alignment: .bottomLeading) {
//                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropPath ?? "")")) { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .opacity(0.7)
//                        .frame(width: imageWidth, height: imageHeight)
//                        .ignoresSafeArea()
//                } placeholder: {
//                    ProgressView()
//                        .frame(width: imageWidth, height: imageHeight)
//                }
//                    VStack(alignment: .leading) {
//                        Text(movie.title)
//                        Text("장르번호 : \(movie.genreIds)")
//                    }
//                    .fontWeight(.bold)
//                    .font(.title)
//                    .padding()
//                    .padding(.bottom, imageWidth * 0.3)
//            }
//            ZStack(alignment: .top) {
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundStyle(.white)
//                VStack(alignment: .trailing, spacing: 0) {
//                    HStack {
//                        Image(systemName: "heart")
//                            .font(.system(size: imageWidth * 0.06))
//                            .padding(.trailing)
//                            .foregroundStyle(.clear)
//                            .disabled(true)
//                        Spacer()
//                        Text("Overview")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        Spacer()
//                        Button(action: {
//                            print("Like button clicked.")
//                        }) {
//                            Image(systemName: "heart")
//                                                            .font(.system(size: imageWidth * 0.06))
//                                                            .padding(.trailing)
//                                                    }
//                                                }
//                                                Text(movie.overview)
//                                                    .font(.title3)
//                                                    .padding()
//                                            }
//                                            .padding(.vertical)
//                                        }
//                                        .padding(.top, imageWidth * -0.3)
//                                    }
//                                }
//                            }

//
//  MoviDetailView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/2/24.
//


import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @StateObject var listVM = BookmarkViewModel()
    var movie: Movie
    
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: movie.backdropURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.7)
                        .frame(width: imageWidth, height: imageHeight)
                        .ignoresSafeArea()
                } placeholder: {
                    ProgressView()
                        .frame(width: imageWidth, height: imageHeight)
                }
                VStack(alignment: .leading) {
                    Text(movie.title)
                }
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .padding(.bottom, imageWidth * 0.3)
            }
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "bookmark.fill")
                            .font(.system(size: imageWidth * 0.06))
                            .padding(.trailing)
                            .foregroundStyle(.clear)
                            .disabled(true)
                        Spacer()
                        Text("Overview")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            print("Like button clicked.")
                            print("Movie name\(movie.title)")
                            
                            let movieTitle = movie.title
                            let movieOverview = movie.overview
                            let movieID = movie.id
                            let movieImages = movie.backdropURL
                            let rated = movie.vote_average
                            
                            let item = Item(id: movieID, images: movieImages, name: movieTitle, description: movieOverview)
                            
                            
                            StorageManager.shared.addItem(item)
                            
                        }) {
                            Image(systemName:"bookmark.fill")
                                .font(.system(size: imageWidth * 0.06))
                                .foregroundColor(.indigo)
                                .padding(.trailing)
                        }
                    }
                    Text(movie.overview)
                        .font(.title3)
                        .padding()
                    
                    // 디테일 뷰의 영화가 현재 상영작일 경우.
                    if homeVM.movies.contains(movie) {
                        Link(destination: URL(string: "https://www.cgv.co.kr/movies/")!) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: imageWidth * 0.6, height: imageWidth * 0.13)
                                    .foregroundStyle(.red)
                                    .opacity(0.4)
                                    .shadow(radius: 3, y: 5)
                                HStack(alignment: .center) {
                                    Image("cgvImage")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: imageWidth * 0.15)
                                        .padding(.bottom, 5)
                                    Text("Ticketing")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.red)
                                }
                                .padding(.leading)
                            }
                        }
                        .padding(.trailing, imageWidth * -0.7)
                    }
                    
                }
                .padding(.vertical)
            }
            .padding(.top, imageWidth * -0.3)
        }
    }
}

//#Preview {
//    MovieDetailView(movie: Movie(id: 123, title: "제목", backdrop_path: "ㅁㄴㅇㄹ", poster_path: "test Poster", overview: "ㅁㄴㅇㄹ", genre_ids: [18], vote_average: 7.77), imageWidth: 100, imageHeight: 200)
//}

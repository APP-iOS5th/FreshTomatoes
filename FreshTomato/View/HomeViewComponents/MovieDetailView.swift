//
//  MoviDetailView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/2/24.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    var movie: Movie
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var body: some View {
        NavigationStack {
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
                        Text("장르번호 : \(movie.genre_ids)")
                    }
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .padding(.bottom, imageWidth * 0.3)
                }
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                    VStack(alignment: .trailing, spacing: 10) {
                        HStack {
                            Image(systemName: "heart")
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
                            }) {
                                Image(systemName: "heart")
                                    .font(.system(size: imageWidth * 0.06))
                                    .padding(.trailing)
                            }
                        }
                        Text(movie.overview)
                            .lineLimit(13)
                            .font(.title3)
                            .padding()
                        
                        // 디테일 뷰의 영화가 현재 상영작일 경우.
                        if homeVM.movies.contains(movie) {
                            Link(destination: URL(string: "https://www.cgv.co.kr/movies/" )!) {
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
                                .padding(.trailing, imageWidth * -0.1)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.top, imageWidth * -0.3)
            }
        }
    }
}

#Preview {
    MovieDetailView(movie: Movie(id: 123, title: "제목", backdrop_path: "ㅁㄴㅇㄹ", poster_path: "test Poster", overview: "ㅁㄴㅇㄹ", genre_ids: [18], vote_average: 7.77), imageWidth: 100, imageHeight: 200)
}

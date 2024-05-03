//
//  ViewAllCardView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/3/24.
//

import SwiftUI

struct ViewAllCardView: View {
    var movies: [Movie]
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var detailViewWidth: CGFloat
    var detailViewHeight: CGFloat
    
    // 3 열
    let colums: [GridItem] = Array(repeating: .init(.fixed(100), spacing: 30), count: 3)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums, spacing: 10) {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie, imageWidth: detailViewWidth, imageHeight: detailViewHeight)) {
                            ZStack(alignment: .top) {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: imageWidth, height: imageHeight * 1.15)
                                    .foregroundStyle(.white)
                                    .opacity(0.8)
                                VStack(alignment: .center) {
                                    if let posterURL = movie.posterURL {
                                        AsyncImage(url: posterURL) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: imageWidth, height: imageHeight)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        } placeholder: {
                                            Color.gray
                                                .frame(width: imageWidth, height: imageHeight)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
                                    }else {
                                        ProgressView()
                                            .frame(width: imageWidth, height: imageHeight)
                                    }
                                    Text(movie.title)
                                        .font(.footnote)
                                        .padding(.horizontal, 10)
                                        .lineLimit(1)
                                }
                            }
                            .shadow(radius: 5)
                            .foregroundStyle(.black)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

//#Preview {
//    ViewAllCardView(movies: [Movie(id: 123, title: "제목1", backdrop_path: "1111", poster_path: "test1 Poster", overview: "ㅁㄴㅇㄹ1111", genre_ids: [18], vote_average: 1.77), Movie(id: 123, title: "제목2", backdrop_path: "ㅁㄴㅇㄹ", poster_path: "test Poster", overview: "ㅁㄴㅇㄹ", genre_ids: [18], vote_average: 2.77), Movie(id: 123, title: "제목3", backdrop_path: "ㅁㄴㅇㄹ", poster_path: "test Poster", overview: "ㅁㄴㅇㄹ", genre_ids: [18], vote_average: 3.77)], imageWidth: 160, imageHeight: 200)
//}


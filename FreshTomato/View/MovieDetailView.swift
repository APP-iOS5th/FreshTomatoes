//
//  MoviDetailView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/2/24.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var listVM = BookmarkViewModel()
    var movie: Movie
    
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    @State private var isLiked = false
    
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
                VStack(alignment: .trailing, spacing: 0) {
                    HStack {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
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
                            isLiked.toggle()
                            print("Like button clicked.")
                                    listVM.setStorage(movie: movie)
                        }) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .font(.system(size: imageWidth * 0.06))
                                .foregroundColor(isLiked ? .red : .gray)
                                .padding(.trailing)
                        }
                    }
                    Text(movie.overview)
                        .font(.title3)
                        .padding()
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

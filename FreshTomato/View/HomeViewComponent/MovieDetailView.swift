//
//  MoviDetailView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/2/24.
//

import SwiftUI

struct MovieDetailView: View {
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
                            // UserDefaults 구현
                            let id =  movie.id
                            let title = movie.title
                            let description = movie.overview
                            let url = movie.backdrop_path
                           
                            let movieInfo = Item(id: id, images: url ?? "pencil", name: title, description: description)
                            
                            StorageManager.shared.addItem(movieInfo)
                            print("Like button clicked.")
                        }) {
                            Image(systemName: "heart")
                                .font(.system(size: imageWidth * 0.06))
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

#Preview {
    MovieDetailView(movie: Movie(id: 123, title: "제목", backdrop_path: "ㅁㄴㅇㄹ", poster_path: "test Poster", overview: "ㅁㄴㅇㄹ", genre_ids: [18], vote_average: 7.77), imageWidth: 100, imageHeight: 200)
}

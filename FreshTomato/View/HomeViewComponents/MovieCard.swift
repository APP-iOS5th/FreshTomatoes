//
//  MovieCard.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/1/24.
//

import SwiftUI

struct MovieCard: View {
    var movie: Movie
    var recWidth: CGFloat
    var recHeight: CGFloat
    
    var imageType: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: imageType == "Poster" ? movie.posterURL : movie.backdropURL) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: recWidth, height: recHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
//                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .fontWeight(.heavy)
                    .font(.system(size: 12))
                HStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                    Text(String(format: "%.1f", movie.vote_average))
                        .font(.system(size: 10))
                }
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.leading, 7)
            .padding(.bottom, 7)
        }
    }
}

#Preview {
    MovieCard(movie: Movie(id: 123, title: "test 제목", backdrop_path: "test backdrop", poster_path: "test poster", overview: "test overview.", genre_ids: [18], vote_average: 7.77), recWidth: 100, recHeight: 200, imageType: "Poster")
}

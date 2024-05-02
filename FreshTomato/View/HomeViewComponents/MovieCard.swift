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
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(imageType == "Poster" ? movie.posterPath ?? "" : movie.backdropPath ?? "")")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: recWidth, height: recHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .fontWeight(.heavy)
                    .font(.system(size: 12))
                HStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                    Text(String(format: "%.1f", movie.voteAverage))
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
    MovieCard(movie: Movie(adult: false , backdropPath: "/qrGtVFxaD8c7et0jUtaYhyTzzPg.jpg", genreIds: [1,2,3,], id: 1234, originalLanguage: "en", originalTitle: "holy", overview: "asdfasdfasdf", popularity: 6.123, posterPath: "/oWxcdRJ0lBJ8kYtoWZelXoHkTz1.jpg", releaseDate: "2024.10.12", title: "holyShit!", video: false, voteAverage: 7.200, voteCount: 100), recWidth: 150, recHeight: 100, imageType: "Poster")
}

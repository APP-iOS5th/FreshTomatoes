//
//  NowShowingCardView.swift
//  FreshTomato
//
//  Created by 조성빈 on 4/30/24.
//

import SwiftUI

struct NowShowingCardView: View {
    var recWidth: CGFloat
    var recHeight: CGFloat
    
    var movie: Movie
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: recWidth, height: recHeight)
                .foregroundStyle(.white)
                .opacity(0.6)
                .shadow(radius: 10)
            VStack {
                // 포스터 이미지
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: recHeight * 0.54)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } placeholder: {
                    ProgressView()
                }
                // 제목, 평점
                VStack {
                    Text(movie.title)
                        .font(.system(size: 15))
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 13))
                        Text(String(format: "%.1f", movie.voteAverage))
                            .font(.system(size: 13))
                    }
                }
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    NowShowingCardView(recWidth: 230, recHeight: 350, movie: Movie(adult: false , backdropPath: "/oWxcdRJ0lBJ8kYtoWZelXoHkTz1.jpg", genreIds: [1,2,3,], id: 1234, originalLanguage: "en", originalTitle: "holy", overview: "asdfasdfasdf", popularity: 6.123, posterPath: "/oWxcdRJ0lBJ8kYtoWZelXoHkTz1.jpg", releaseDate: "2024.10.12", title: "holyShit!", video: false, voteAverage: 7.200, voteCount: 100))
}

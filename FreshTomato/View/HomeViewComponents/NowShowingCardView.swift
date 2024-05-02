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
                .opacity(0.7)
                .shadow(radius: 10)
            VStack {
                // 포스터 이미지
                AsyncImage(url: movie.posterURL) { image in
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
                        Text(String(format: "%.1f", movie.vote_average))
                            .font(.system(size: 13))
                    }
                }
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    NowShowingCardView(recWidth: 230, recHeight: 350, movie: Movie(id: 123, title: "제목", backdrop_path: "ㅁㄴㅇㄹ", poster_path: "test Poster", overview: "ㅁㄴㅇㄹ", genre_ids: [18], vote_average: 7.77 ))
}

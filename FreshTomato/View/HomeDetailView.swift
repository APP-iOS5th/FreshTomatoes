//
//  HomeDetailView.swift
//  FreshTomato
//
//  Created by 임재현 on 5/2/24.
//

import SwiftUI

struct MovieDetailView: View {
     var movie: Movie
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    @AppStorage("favoriteMovieTitle") var favoriteMovieTitle: String = ""
    @AppStorage("favoriteMovieOverview") var favoriteMovieOverview: String = ""

    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {

                AsyncImage(url: movie.backdropURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.6)
                        .frame(width: imageWidth, height: imageHeight)
                } placeholder: {
                    ProgressView()
                        .frame(width: imageWidth, height: imageHeight)
                }
                .ignoresSafeArea()
                    VStack(alignment: .leading) {
                        Text("\(movie.title)")
                        Text("장르번호 : \(movie.genre_ids)")
                    }
                    .fontWeight(.bold)
                    .font(.system(size: imageWidth * 0.04))
                    .padding()
                    .padding(.bottom, imageWidth * 0.07)
            }
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .padding(.top, -30)
                VStack(alignment: .trailing, spacing: 0) {
                    Button(action: {
                        print("Like button clicked.")
                        print("Movie title\(movie.title)")
                        print("Movie title\(movie.genre_ids)")
                        print("Movie title\(movie.overview)")
                        favoriteMovieTitle = movie.title
                        favoriteMovieOverview = movie.overview
                    }) {
                        Image(systemName: "heart")
                            .font(.system(size: imageWidth * 0.06))
                            .padding(.trailing)
                    }
                    Text("movie.overviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverviewoverview")
                        .padding()
                }
            }
        }
    }
}

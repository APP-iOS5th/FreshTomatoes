//
//  MoviDetailView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/2/24.
//

import SwiftUI

struct MoviDetailView: View {
    var movie: Movie
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(movie.backdropPath ?? "")")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.7)
                        .frame(width: imageWidth, height: imageHeight)
                } placeholder: {
                    ProgressView()
                        .frame(width: imageWidth, height: imageHeight)
                }
                    VStack(alignment: .leading) {
                        Text(movie.title)
                        Text("장르번호 : \(movie.genreIds)")
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
                    }) {
                        Image(systemName: "heart")
                            .font(.system(size: imageWidth * 0.06))
                            .padding(.trailing)
                    }
                    Text(movie.overview)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    MoviDetailView(movie: Movie(adult: false , backdropPath: "/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg", genreIds: [1,2,3,], id: 1234, originalLanguage: "en", originalTitle: "holy", overview: "Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.", popularity: 6.123, posterPath: "/oWxcdRJ0lBJ8kYtoWZelXoHkTz1.jpg", releaseDate: "2024.10.12", title: "holyShit!", video: false, voteAverage: 7.200, voteCount: 100), imageWidth: 500, imageHeight: 300)
}

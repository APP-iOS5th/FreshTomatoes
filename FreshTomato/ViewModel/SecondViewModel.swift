//
//  SecondViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//


import SwiftUI

struct LikeMovieView: View {
    let movieDetail: MovieDetail
    @State private var isLiked = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Image(movieDetail.posterName)
                    .resizable()
                    .frame(width: 110,height: 170)
                    .cornerRadius(20)
              
                VStack(alignment: .leading) {
                    HStack{
                        Text(movieDetail.title)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        Button {
                            isLiked.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .font(.headline)
                                .foregroundColor(isLiked ? .indigo : .gray)
                            }
                    }
                    
                    HStack{
                        Text(movieDetail.year)
                        Text("|")
                        Text(movieDetail.genre)
                        Text("|")
                        Text(movieDetail.runningtime)
                    }
                    .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(movieDetail.rating, specifier: "%.1f")")
                            .foregroundColor(.gray)
                    }
                    
                    Text(movieDetail.description)
                        .lineLimit(nil)
                        .padding(.top, 8)
                }
            }
        }
        .padding()
        .frame(width: 350, height: 200)
    }
}

struct minimovieView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(moviedetails, id: \.title) { moviedetail in
                    LikeMovieView(movieDetail: moviedetail)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
            }
            .padding()
        }
        .navigationTitle("Liked Movies")
    }
}

#Preview {
    minimovieView()
}

//
//  LikeListDetailView.swift
//  FreshTomato
//
//  Created by 육현서 on 5/3/24.
//. 대치 누르니까 된 것 같긴 한데 
 
import SwiftUI

struct LikeMovieList: View {
    
    let movie: Movie
    @State private var isLiked = true

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                AsyncImage(url: movie.posterURL) { image in
                    image
                        .image?.resizable()
                        .frame(width: 110,height: 170)
                        .cornerRadius(20)
                }
              
                VStack(alignment: .leading) {
                    HStack{
                        Text(movie.title)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        Button {
                            isLiked.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .font(.headline)
                                .foregroundColor(isLiked ? .red : .gray)
                            }
                    }
                    
                    HStack{
                        Text("\(movie.genre_ids)")
                    }
                    .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(movie.vote_average, specifier: "%.1f")")
                            .foregroundColor(.gray)
                    }
                    
                    Text(movie.overview)
                        .lineLimit(nil)
                        .padding(.top, 8)
                }
            }
        }
        .padding()
        .frame(width: 350, height: 200)
    }
} //

struct LikeListDetailView: View {
    @StateObject var likemv = BookmarkViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(Array(likemv.storageMovies)) { likemovie in
                    LikeMovieList(movie: likemovie)
                        .background(Color.white) // 배경색 수정
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
            }
            .padding()
        }
        .onAppear {
            likemv.getStorage()
        }
        .navigationTitle("좋아요 한 영화")
    } 
}


struct LikeMovieList_Previews: PreviewProvider {
    static var previews: some View {
        LikeListDetailView()
    }
}


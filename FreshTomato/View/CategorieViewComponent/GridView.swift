//
//  GridView.swift
//  FreshTomato
//
//  Created by 임재현 on 5/3/24.
//

import SwiftUI


//MARK: - 아래 영화 포스터 나타내는 View
struct GridView: View {
    var movies: [Movie]
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(100), spacing: 30), count: 3)
    
    var detailViewWitdh: CGFloat
    var detailViewHeight: CGFloat
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(movies, id: \.self) { movie in
                     NavigationLink(destination: MovieDetailView(movie: movie, imageWidth: detailViewWitdh, imageHeight: detailViewHeight)) {
                         VStack(alignment: .center) {
                             if let imageURL = movie.backdropURL {
                                 AsyncImage(url: imageURL) { image in
                                     image
                                         .resizable()
                                         .scaledToFill()
                                         .frame(width: 100, height: 150)
                                         .clipped()
                                 } placeholder: {
                                     Color.gray
                                         .frame(width: 100, height: 150)
                                 }
                             } else {
                                 Color.gray
                                     .frame(width: 100, height: 150)
                             }
                             Text(movie.title)
                                 .font(.caption)
                                 .multilineTextAlignment(.center)
                                 .frame(width: 100, height: 50)
                                 .lineLimit(2)
                         }
                         .background(Color.white)
                         .cornerRadius(10)
                         .shadow(radius: 5)
                         .frame(width: 100, height: 220)
                     }
                 }
               
                
                   
            }
            .padding(.horizontal)
        }
    }
}

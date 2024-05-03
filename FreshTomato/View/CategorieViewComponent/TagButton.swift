//
//  TagButton.swift
//  FreshTomato
//
//  Created by 임재현 on 5/3/24.
//

import SwiftUI


//MARK: - 위의 TagButton View로 정의
struct TagButton: View {
  
    @Binding var selectedGenre: Int?
    @Binding var selectedGenreDescription: String
    var action: (Int?) -> Void
    let genres = MovieGenre.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Button(action: {
                    action(nil)
                    selectedGenreDescription = "Now Playing"
                }) {
                    Text("All")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.headline)
                        .clipShape(Capsule())
                }

                ForEach(genres, id: \.self) { genre in
                    Button(action: {
                        action(genre.rawValue)
                        selectedGenreDescription = genre.description
                    }) {
                        Text(genre.description)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedGenre == genre.rawValue ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}


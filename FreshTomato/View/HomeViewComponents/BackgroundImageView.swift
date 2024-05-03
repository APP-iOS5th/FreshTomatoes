//
//  BackgroundImageView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/2/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var backImage: String
    
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original\(backImage)")) { image in
            image
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .overlay {
                    LinearGradient(colors: [.white, .clear, .clear, .white], startPoint: .top, endPoint: .bottom)
                }
        } placeholder: {
            ProgressView()
        }
        .padding(.top, imageWidth * 0.03)
    }
}

#Preview {
    BackgroundImageView(backImage: "", imageWidth: 1, imageHeight: 1)
}

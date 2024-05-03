//
//  TitleView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/1/24.
//

import SwiftUI

struct TitleView: View {
    
    var semiTitle: String
    var title: String
    var buttonTitle: String
    
    var movies: [Movie]
    var allViewImageWidth: CGFloat
    var allViewImageHeight: CGFloat
    
    var detailViewWidth: CGFloat
    var detailViewHeight: CGFloat
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(semiTitle)
                    .fontWeight(.light)
                    .font(.headline)
                Text(title)
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundStyle(.red)
            }
            Spacer()
                NavigationLink(destination: ViewAllCardView(movies: movies, imageWidth: allViewImageWidth, imageHeight: allViewImageHeight, detailViewWidth: detailViewWidth, detailViewHeight: detailViewHeight)) {
                        Text(buttonTitle)
                            .foregroundStyle(.red)
                            .padding(.bottom, 4)
                }
        }
    }
}

//#Preview {
//    TitleView(semiTitle: "Fresh Tomatoes", title: "NOW SHOWING", buttonTitle: "View all")
//}


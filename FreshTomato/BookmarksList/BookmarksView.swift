//
//  BookmarksView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        List {
            Section {
                
            } header: {
                Text("My Page")
            }
            
        }
    }
}

#Preview {
    BookmarksView()
}


//struct BookmarksRow: View {
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Image(systemName: "heart.circle.fill")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                Text("좋아요")
//                    .font(.title2)
//                Spacer()
//            }
//            HStack {
//                Image(systemName: "hand.thumbsdown.circle.fill")
//                    .resizable()
//                    .frame(width: 30, height: 30)
//                Text("별로예요")
//                    .font(.title2)
//                Spacer()
//            }
//        }
//    }
//}

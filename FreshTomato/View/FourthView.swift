//
//  FourthView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

//struct FourthView: View {
//    @StateObject private var viewModel = FourthViewModel()
//
//    var body: some View {
//        
//        
//        
//        
//        NavigationView {
//            List {
//                ForEach(viewModel.items, id: \.id) { item in
//                    
//                  
//                    
//                    
//                    
//                    
//                    
////
////                    
////                    
////                    
////                  
////                    VStack(alignment: .leading) {
////                        Text(item.name)
////                            .font(.headline)
////                        Text(item.description)
////                            .font(.subheadline)
////                        Text(item.images)
////                            .font(.caption)
////                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .task {
//                viewModel.loadItems()
//            }
//            .navigationTitle("Saved Items")
//            
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let itemID = viewModel.items[index].id
//            viewModel.deleteItem(withID: itemID)
//        }
//    }
//}

import SwiftUI

struct FourthView: View {
    @StateObject private var viewModel = FourthViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.items, id: \.id) { item in
                        LikeListDetailView(item: item)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Saved Items")
            .onAppear {
                viewModel.loadItems()
               
            }
        }
    }

}







//struct ItemView: View {
//    var item: Item
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(item.name)
//                .font(.headline)
//            Text(item.description)
//                .font(.subheadline)
//            AsyncImage(url: URL(string: item.images)) { phase in
//                switch phase {
//                case .success(let image):
//                    image.resizable()
//                         .aspectRatio(contentMode: .fit)
//                         .frame(width: 100, height: 100)
//                case .failure:
//                    Text("이미지 로드 실패")
//                case .empty:
//                    ProgressView()
//                @unknown default:
//                    EmptyView()
//                }
//            }
//        }
//    }
//}
//import SwiftUI

struct LikeListDetailView: View {

    let item: Item
    

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
              
                AsyncImage(url: item.posterURL) { image in
                    image
                        .image?.resizable()
                        .frame(width: 110,height: 170)
                        .cornerRadius(20)
                }

                VStack(alignment: .leading) {
                    HStack{
                        Text(item.name)
                            .font(.title)
                            .bold()

                        Spacer()
                        Button {
                            StorageManager.shared.deleteItem(withID: item.id)
                        
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .foregroundColor(.gray)
                            }
                    }

                    HStack{
//                        Text("(movie.genre_ids)")
                    }
                    .foregroundColor(.gray)

                    HStack {
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
                        
                       // Text("\(item.rated, specifier: "%.1f")")
                        
                       // Text("\(item.rated, specifier: "%.1f")")
                       // Text("hihi")
//                            .foregroundColor(.gray)
                    }
                      Text(item.description)
                        .lineLimit(nil)
                        .padding(.top, 8)
                }
            }
        }
     
        
        .padding()
        .frame(width: 350, height: 200)
    }
}

//struct LikeListDetailView: View {
//    @StateObject var likemv = BookmarkViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                ForEach(Array(likemv.storageMovies)) { likemovie in
//                    LikeMovieList(movie: likemovie)
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .shadow(radius: 5)
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            likemv.getStorage()
//        }
//        .navigationTitle("좋아요 한 영화")
//    }
//}
//







//struct FourthView: View {
//    
//   
//
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                Section(header: Text("나의 목록")) {
//                   
//                    
//                    
//                    
//                }
//                
//                Section(header: Text("나의 평점")) {
//                    
//                }
//            }
//            .padding()
//            .navigationTitle("My Page")
//        }
//    }
//}
//
//#Preview {
//    FourthView()
//}

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
                   LikeListDetailView(item: item, viewModel: viewModel)  // ViewModel 주입
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

struct LikeListDetailView: View {
    let item: Item
    @ObservedObject var viewModel: FourthViewModel  // 상위 뷰에서 받아오도록 변경

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                AsyncImage(url: item.posterURL) { phase in  // URL 생성 방식 변경
                    switch phase {
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fill)
                             .frame(width: 110, height: 170)
                             .cornerRadius(20)
                    case .failure(_):
                        Text("이미지를 불러올 수 없습니다.")
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }

                VStack(alignment: .leading) {
                    HStack{
                        Text(item.name)
                            .font(.title)
                            .bold()

                        Spacer()
                        Button {
                            viewModel.deleteItem(withID: item.id)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    Text(item.description)
                        .lineLimit(nil)
                        .padding(.top, 8)
                }
            }
        }
        .frame(width: 300,height: 200)
    }
}

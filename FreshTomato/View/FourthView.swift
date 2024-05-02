//
//  FourthView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct FourthView: View {
    @StateObject private var viewModel = FourthViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.description)
                            .font(.subheadline)
                        Text(item.images)
                            .font(.caption)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .task {
                viewModel.loadItems()
            }
            .navigationTitle("Saved Items")
            
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        offsets.forEach { index in
            let itemID = viewModel.items[index].id
            viewModel.deleteItem(withID: itemID)
        }
    }
}


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

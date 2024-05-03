//
//  FourthView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct FourthView: View {
    
    @StateObject var listVm = BookmarkViewModel() 

    var body: some View {
        VStack {
            
        }
////        NavigationStack {.
//////            VStack {
//////                if !listVm.storageMovies.isEmpty {
//////                    ForEach(listVm.storageMovies, id: \.self) { movie in
//////                        Text(movie.title)
//////                    }
//////                } else {
//////                    Text ("Add Movie !") 
////                }
//            }
//            List {
//                Section(header: Text("나의 목록")) { 네네
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
//        .onAppear {
//            listVm.getStorage()
//        }
    }
}

//#Preview {
//    FourthView()
//}

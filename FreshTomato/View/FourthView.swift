//
//  FourthView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct FourthView: View {
    
    @StateObject var homeVm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(homeVm.storageMovies, id: \.self) { movie in
                    Text(movie.title)
                }
            }
//            List {
//                Section(header: Text("나의 목록")) {
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
        }
        .onAppear {
            homeVm.getStorage()
        }
    }
}

#Preview {
    FourthView()
}

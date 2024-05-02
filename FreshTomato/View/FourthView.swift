//
//  FourthView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct FourthView: View {
    
    @AppStorage("favoriteMovieTitle") var favoriteMovieTitle: String = ""
        @AppStorage("favoriteMovieOverview") var favoriteMovieOverview: String = ""

    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("나의 목록")) {
                    
                    Text("favariote\(favoriteMovieTitle)")
                    Text("favariote\(favoriteMovieOverview)")
                }
                
                Section(header: Text("나의 평점")) {
                    
                }
            }
            .padding()
            .navigationTitle("My Page")
        }
    }
}

#Preview {
    FourthView()
}

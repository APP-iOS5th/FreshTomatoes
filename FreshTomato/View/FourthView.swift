//
//  FourthView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct FourthView: View {
    
   

    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("나의 목록")) {
                   
                    
                    
                    
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

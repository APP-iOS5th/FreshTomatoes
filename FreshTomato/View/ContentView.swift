//
//  ContentView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
           HomeView()
                .tabItem {
                    Image(systemName: "heart.fill")
                                       Text("One")
                }
           SecondView()
                .tabItem {
                    Image(systemName: "heart.fill")
                         Text("Two")
                }
           ThirdView()
                .tabItem {
                    Image(systemName: "heart.fill")
                         Text("Three")
                }
           
        }
       // .tabViewStyle(.page)
                   .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    ContentView()
}

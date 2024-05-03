//
//  ContentView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//


import SwiftUI

struct ContentView: View {
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    @State private var currentTab: Tab = .home
    
        var body: some View {
            VStack(spacing: 0) {
                TabView(selection: $currentTab) {
                    HomeView(currentTab: $currentTab)
                        .tag(Tab.home)
                    SecondView()
                        .tag(Tab.nowandupcoming)
                    ThirdView()
                        .tag(Tab.search)
                    FourthView()
                        .tag(Tab.my)
                }
    
                CustomTabBarView(currentTab: $currentTab)
            }
        }
    }
    
//    var body: some View {
//        VStack(spacing: 0) {
//            TabView(selection: $currentTab) {
//                Text(currentTab.rawValue)
//                    .applyBG()
//                    .tag(Tab.home)
//            }
//            CustomTabBarView(currentTab: $currentTab)
//        }
//        
//    }


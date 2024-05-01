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
                Text(currentTab.rawValue)
                    .applyBG()
                    .tag(Tab.home)
            }
            CustomTabBarView(currentTab: $currentTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//이전 탭뷰 코드
//struct ContentView: View {
//    var body: some View {
//        TabView {
//           HomeView()
//                .tabItem {
//                    Image(systemName: "house")
//                                       Text("HOME")
//                }
//           SecondView()
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                         Text("상영작")
//                }
//           ThirdView()
//                .tabItem {
//                    Image(systemName: "heart.fill")
//                         Text("랭킹")
//                }
//           FourthView()
//             .tabItem {
//                 Image(systemName: "heart.fill")
//                      Text("MY")
//             }
//
//        }
//       // .tabViewStyle(.page)
//                   .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//    }
//}


//#Preview {
//    ContentView()
//}

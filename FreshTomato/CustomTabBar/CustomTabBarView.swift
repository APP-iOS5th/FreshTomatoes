//
//  CustomTabBarView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var currentTab: Tab
    @State var yOffset:CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id: \.self) { tab in
                    Button {
                        withAnimation(.easeOut(duration: 0.3)) {
                            currentTab = tab
                            yOffset = -50
                        }
                        
                        withAnimation(.easeOut(duration: 0.1).delay(0.07)) {
                            yOffset = 0
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: getImage(rawValue: tab.rawValue))
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .foregroundColor(currentTab == tab ? .indigo : .gray)
                                .scaleEffect(currentTab == tab ? 1.3 : 1)
                            
                            Text(tab.rawValue)
                                .font(.caption)
                                .foregroundColor(currentTab == tab ? .indigo : .gray)
                        }
                    }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(alignment: .leading) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                    .offset(x: 15, y: yOffset-1.5)
                    .offset(x:indicatorOffset(width: width))
                    .shadow(color: .indigo, radius: 7)
            }
        }
        .frame(height: 70)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
    }
    
    func indicatorOffset(width:CGFloat) -> CGFloat {
        let index = CGFloat(getIndex())
        if index == 0 {
            return 0
        }
        let buttonWidth = width / CGFloat(Tab.allCases.count)
        return index * buttonWidth
    }
    
    func getIndex() -> Int {
        switch currentTab {
        case .home:
            return 0
        case .nowandupcoming:
            return 1
        case .search:
            return 2
        case .my:
            return 3
        }
    }
    
    func getImage(rawValue: String) -> String {
        switch rawValue {
        case "HOME":
            return "house.fill"
        case "상영작":
            return "movieclapper.fill"
        case "검색":
            return "magnifyingglass.circle.fill"
        case "MY":
            return "person.fill"
        default:
            return ""
        }
    }
}

#Preview {
    CustomTabBarView(currentTab: .constant(.home))
}

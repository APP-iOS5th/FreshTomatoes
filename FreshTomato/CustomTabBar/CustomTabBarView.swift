//
//  CustomTabBarView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var currentTab: Tab
    @State var yOffset: CGFloat = 0
    
    private var tabNames: [String] {
        Tab.allCases.map { $0.rawValue }
    }
    
    var body: some View {
        let geometry = GeometryReader { proxy in
            let width = proxy.size.width
            
            HStack(spacing: 0) {
                ForEach(Array(zip(Tab.allCases, tabNames)), id: \.0) { tab, name in
                    VStack(spacing: 4) {
                        Button {
                            withAnimation(.easeOut(duration: 0.2)) {
                                currentTab = tab
                                yOffset = -40
                            }
                            
                            withAnimation(.easeOut(duration: 0.1).delay(0.07)) {
                                yOffset = 0
                            }
                        } label: {
                            Image(systemName: getImage(rawValue: tab.rawValue))
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.5, height: 20.5)
                                .foregroundColor(currentTab == tab ? .indigo : .gray)
                                .scaleEffect(currentTab == tab ? 1.3 : 1)
                            
                        }
                        
                        Text(name)
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(currentTab == tab ? .indigo : .gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(alignment: .leading) {
                Circle()
                    .fill(.white)
                    .frame(width: 55, height: 55)
                    .offset(x: 17, y: yOffset-1.5)
                    .offset(x:indicatorOffset(width: width))
                    .shadow(color: .indigo, radius: 5)
            }
        }
        
        return geometry
            .frame(height: 60)
            .padding(.horizontal)
            .padding(.top, 10)
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
        case .rankings:
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
        case "랭킹":
            return "trophy.fill"
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

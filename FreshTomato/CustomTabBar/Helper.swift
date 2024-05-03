//
//  Helper.swift
//  FreshTomato
//
//  Created by Jude Song on 5/1/24.
//

import SwiftUI

extension View {
    func applyBG() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

enum Tab: String, CaseIterable {
    case home = "HOME"
    case nowandupcoming = "상영작"
    case search = "검색"
    case my = "MY"
}

extension Tab {
    var tabItem: some View {
        switch self {
        case .home:
            return AnyView(
                Label("HOME", systemImage: "house.fill")
            )
        case .nowandupcoming:
            return AnyView(
                Label("상영작", systemImage: "movieclapper.fill")
            )
        case .search:
            return AnyView(
                Label("검색", systemImage: "magnifyingglass.circle.fill")
            )
        case .my:
            return AnyView(
                Label("MY", systemImage: "person.fill")
            )
        }
    }
}

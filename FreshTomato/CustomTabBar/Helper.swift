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
    case rankings = "랭킹"
    case my = "MY"
}

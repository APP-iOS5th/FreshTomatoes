//
//  FreshTomatoApp.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI

@main
struct FreshTomatoApp: App {
    @StateObject var homeVM: HomeViewModel = HomeViewModel()
    init() {
            for family: String in UIFont.familyNames {
                print(family)
                for names: String in UIFont.fontNames(forFamilyName: family) {
                    print("=== \(names)")
                }
            }
        }
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(homeVM)
            
            
        }
    }
}

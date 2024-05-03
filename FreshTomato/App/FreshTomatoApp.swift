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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeVM)
        }
    }
}

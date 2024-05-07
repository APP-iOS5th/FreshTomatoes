//
//  SplashView.swift
//  FreshTomato
//
//  Created by 임재현 on 5/7/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var homeVM: HomeViewModel // ViewModel 참조를 추가합니다.
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(homeVM)  // 여기에 environmentObject를 넘겨줍니다.
        } else {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                HStack {
                    Text("Fresh Tomatoes")
                        .font(.BagelFatOne36)
                        .foregroundColor(.newPrimaryColor)

                    Image("tomato")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

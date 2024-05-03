//
//  SplashView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/3/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("Fresh Tomatoes")
                .font(.title)
                .foregroundColor(.red)
            }
        }
    }

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

//
//  TitleView.swift
//  FreshTomato
//
//  Created by 조성빈 on 5/1/24.
//

import SwiftUI

struct TitleView: View {
    var semiTitle: String
    var title: String
    var buttonTitle: String
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text(semiTitle)
                    .fontWeight(.light)
                    .font(.headline)
                Text(title)
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundStyle(.red)
            }
            Spacer()
            Button(action: {
                print("MOVIE INFO view all button clicked.")
            }) {
                Text(buttonTitle)
                    .foregroundStyle(.red)
                    .padding(.bottom, 4)
            }
        }
    }
}

#Preview {
    TitleView(semiTitle: "Fresh Tomatoes", title: "NOW SHOWING", buttonTitle: "View all")
}

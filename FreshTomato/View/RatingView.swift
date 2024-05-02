//
//  RatingView.swift
//  FreshTomato
//
//  Created by Jude Song on 5/2/24.
//

//상세 페이지에 들어가기

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumrRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumrRating + 1, id: \.self) { number in
                Button {
                    print("Tapped \(number)")
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingViewPreview()
    }
    
    struct RatingViewPreview: View {
        @State private var rating = 0
        
        var body: some View {
            RatingView(rating: $rating)
        }
    }
}
//#Preview {
//    RatingView(rating: .constant(3))
//}

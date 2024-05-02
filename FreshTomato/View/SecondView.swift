//
//  SecondView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.


import SwiftUI

struct SecondView: View {
    var body: some View {
        // 좋아요(북마크) 기록 기본 화면 - 데이터 없을 때
        NavigationView{
            VStack{
                Text("관심목록에 추가된 데이터가 없습니다.")
                    .padding()
                
                // 영화 좋아요(북마크) 누르러 페이지 이동 (?) -> 텍스트인지 버튼인지 잘 모르겠음
                NavigationLink(destination: HomeView()) {
                    Text("Add Movie")
                        .foregroundStyle(.indigo)
                        .bold()
                }
            }
        }
    }
}

#Preview {
    SecondView()
}

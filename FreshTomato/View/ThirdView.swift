//
//  ThirdView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI

struct ThirdView: View {
    @StateObject var vm: ThirdViewModel = ThirdViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("검색", text: $searchText, onCommit: {
                    vm.fetchSearchResults(query: searchText)
                })
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 10)

                // 조건부 뷰 로직으로 결과에 따라 다른 뷰를 표시
                if vm.searchMovies.isEmpty {
                    if searchText.isEmpty {
                        // 초기 상태 메시지
                        Spacer()
                        Text("영화를 검색해주세요.")
                            .foregroundColor(.gray)
                            .font(.headline)
                        Spacer()
                    } else {
                        // 검색 결과가 없는 경우 메시지
                        Spacer()
                        Text("검색 결과가 없습니다.")
                            .foregroundColor(.gray)
                            .font(.headline)
                        Spacer()
                    }
                } else {
                    // 검색 결과가 있는 경우 카드 뷰 표시
                    GeometryReader { geometry in
                        ViewAllCardView(movies: vm.searchMovies, imageWidth: geometry.size.width * 0.27, imageHeight: geometry.size.height * 0.21, detailViewWidth: geometry.size.width, detailViewHeight: geometry.size.height * 0.4)
                    }
                }

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("영화 검색")
        }
    }
}


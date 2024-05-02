//
//  SecondView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI

//MARK: -  TabView에서 두번째 View 구현
struct SecondView: View {
    
    @StateObject var vm :SecondViewModel = SecondViewModel()

    var body: some View {
        NavigationStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    // 맨 위에 카테고리 제목 아래 탭 버튼 구현
                    TagButton(selectedGenre: $vm.selectedGenre,
                              selectedGenreDescription: $vm.selectedGenreDescription,
                              action: vm.filterMoviesByGenre)
                    // 각 버튼 클릭하면 그 버튼 이름과 동일하게 바뀌도록 구현
                    Text(vm.selectedGenreDescription)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 8)
                    // api로 받아온 데이터를 바탕으로  3열짜리 ScrollView 구현
                    GridView(movies: vm.filteredMovies)
                        .padding(.top, 8)
                        .navigationTitle("Categories")
                }
            }
            //  데이터 받아오는게 View 그리는것보다 늦어질 수 있으므로 비동기 처리로 데이터가 받아와지면 그때 실행되고, 그후 View를 다시 그림
            .onAppear {
                vm.fetchMoviesFromMultiplePages(pages:vm.pages)
            }
        }
    }
    
}










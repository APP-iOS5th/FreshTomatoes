//
//  SecondView.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//

import SwiftUI

//MARK: -  TabView에서 두번째 View 구현
struct SecondView: View {
    @State var movies: [Movie] = []
    @State var filteredMovies: [Movie] = []
    @State var selectedGenre: Int? = nil
    @State var isLoading = false
    @State var selectedGenreDescription: String = "Now Playing"
    
    
    var body: some View {
        NavigationStack {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    // 맨 위에 카테고리 제목 아래 탭 버튼 구현
                    TagButton(selectedGenre: $selectedGenre, selectedGenreDescription: $selectedGenreDescription, action: filterMoviesByGenre)
                    
                    // 각 버튼 클릭하면 그 버튼 이름과 동일하게 바뀌도록 구현
                    Text(selectedGenreDescription)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 8)
                    
                    // api로 받아온 데이터를 바탕으로  3열짜리 ScrollView 구현
                    GridView(movies: filteredMovies)
                        .padding(.top, 8)
                        .navigationTitle("Categories")
                }
            }
            //  데이터 받아오는게 View 그리는것보다 늦어질 수 있으므로 비동기 처리로 데이터가 받아와지면 그때 실행되고, 그후 View를 다시 그림
            .onAppear {
                fetchMoviesFromMultiplePages()
            }
        }
    }
    
    //MARK: - 각 page마다 가져올수 있는 데이터가 한정되어있어 여러개의 페이지를 동시에 가져와서 작업하는 함수(page가 5개이니 5개의 페이지의 함수가 호출)
    func fetchMoviesFromMultiplePages() {
        isLoading = true
        let pages = [1,2,3,4,5]
        var allMovies = [Movie]()
        let group = DispatchGroup()
        
        for page in pages {
            group.enter()
            MovieService.shared.fetchNowPlayingMovies(language: "ko-KR", page: page, region: "KR") { result in
                defer { group.leave() }
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async {
                        allMovies.append(contentsOf: movies)
                    }
                case .failure(let error):
                    print("Error fetching page \(page): \(error)")
                }
            }
        }
        
        group.notify(queue: .main) {
            let uniqueMovies = Set(allMovies).sorted(by: { $0.id < $1.id })
            self.movies = Array(uniqueMovies)
            self.filteredMovies = Array(uniqueMovies)
            self.isLoading = false
        }
    }
    
    //MARK: - Movie 에서 가져온 장르 번호 바탕으로 필터 하는 함수
    func fetchNowPlayingMovies(pages:Int) {
        isLoading = true
        MovieService.shared.fetchNowPlayingMovies(language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = Set<Movie>()
                    movies.forEach { uniqueMovies.insert($0) }
                    
                    self.movies.removeAll()
                    self.filteredMovies.removeAll()
                    
                    self.movies = Array(uniqueMovies)
                    self.filteredMovies = Array(uniqueMovies)
                    
                    isLoading = false
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
                isLoading = false
            }
        }
    }
    
    //MARK: - Movie 에서 가져온 장르 번호 바탕으로 필터 하는 함수
    func filterMoviesByGenre(genre: Int?) {
        selectedGenre = genre
        if let genre = genre {
            filteredMovies = movies.filter { $0.genre_ids.contains(genre) }
        } else {
            filteredMovies = movies
        }
    }

}


//MARK: - 위의 TagButton View로 정의
struct TagButton: View {
    @Binding var selectedGenre: Int?
    @Binding var selectedGenreDescription: String
    var action: (Int?) -> Void
    let genres = MovieGenre.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Button(action: {
                    action(nil)
                    selectedGenreDescription = "Now Playing"
                }) {
                    Text("All")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.headline)
                        .clipShape(Capsule())
                }

                ForEach(genres, id: \.self) { genre in
                    Button(action: {
                        action(genre.rawValue)
                        selectedGenreDescription = genre.description
                    }) {
                        Text(genre.description)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(selectedGenre == genre.rawValue ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .font(.headline)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}



//MARK: - 아래 영화 포스터 나타내는 View
struct GridView: View {
    var movies: [Movie]
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(100), spacing: 30), count: 3)
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(movies, id: \.self) { movie in
                    VStack(alignment: .center) {
                        if let imageURL = movie.backdropURL {
                            AsyncImage(url: imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 150)
                                    .clipped()
                            } placeholder: {
                                Color.gray
                                    .frame(width: 100, height: 150)
                            }
                        } else {
                            Color.gray
                                .frame(width: 100, height: 150)
                        }
                        
                        Text(movie.title)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .frame(width: 100, height: 50)
                            .lineLimit(2)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .frame(width: 100, height: 220)
                }
            }
            .padding(.horizontal)
        }
    }
}

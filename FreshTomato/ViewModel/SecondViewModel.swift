//
//  SecondViewModel.swift
//  FreshTomato
//
//  Created by 임재현 on 4/30/24.
//



import Foundation

class SecondViewModel: ObservableObject {

    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var selectedGenre: Int? = nil
    @Published var selectedGenreDescription: String = "Now Playing"
    @Published var pages: [Int] = [1,2,3,4,5]
    @Published var genres = MovieGenre.allCases

    //MARK: - API 로 데이터 받아오는 함수
    func fetchNowPlayingMovies(pages:Int) {
      //  isLoading = true
        MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: "ko-KR", page: pages, region: "KR") { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    var uniqueMovies = Set<Movie>()
                    movies.forEach { uniqueMovies.insert($0) }
                    
                    self.movies.removeAll()
                    self.filteredMovies.removeAll()
                    
                    self.movies = Array(uniqueMovies)
                    self.filteredMovies = Array(uniqueMovies)
                    
                   // isLoading = false
                }
            case .failure(let error):
                print("Failed to fetch movies: \(error)")
           //     isLoading = false
            }
        }
    }
    
    //MARK: - 각 page마다 가져올수 있는 데이터가 한정되어있어 여러개의 페이지를 동시에 가져와서 작업하는 함수(page가 5개이니 5개의 페이지의 함수가 호출)
    func fetchMoviesFromMultiplePages(pages:[Int]) {
        //        isLoading = true
        let pages = pages
        var allMovies = [Movie]()
        let group = DispatchGroup()
        
        for page in pages {
            group.enter()
            MovieService.shared.fetchNowPlayingMovies(boxOfficeStatus: .nowPlaying, language: "ko-KR", page: page, region: "KR") { result in
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
            //    self.isLoading = false
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

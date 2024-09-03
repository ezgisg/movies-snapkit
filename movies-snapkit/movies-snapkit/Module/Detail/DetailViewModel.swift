//
//  DetailViewModel.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 3.09.2024.
//

import Foundation

//MARK: - DetailViewModelProtocol
protocol DetailViewModelProtocol: AnyObject {
    var movieID: Int { get set }
    var movieDetail: MovieDetailsResponse? { get set }
    var similars: MoviesResponse?  { get set }
    var delegate: DetailViewModelDelegate? { get set }
    
    func fetchDetail()
    func fetchSimilars()
}

//MARK: - DetailViewModelDelegate
protocol DetailViewModelDelegate: AnyObject {
    func reloadData()
    func configureData()
}

//MARK: - DetailViewModel
final class DetailViewModel {
    var movieID: Int
    var movieDetail: MovieDetailsResponse?
    var similars: MoviesResponse?
    weak var delegate: DetailViewModelDelegate?
    private var service = MoviesService()
  
    
    init(movieID: Int) {
        self.movieID = movieID
    }
}

//MARK: - DetailViewModelProtocol
extension DetailViewModel: DetailViewModelProtocol {
    func fetchDetail() {
        service.fetchMovieDetails(movieId: Int32(movieID)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                movieDetail = data
                delegate?.configureData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fetchSimilars() {
        service.fetchSimilarMovies(page: 1, movieId: Int32(movieID)) {  [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                similars = data
                delegate?.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

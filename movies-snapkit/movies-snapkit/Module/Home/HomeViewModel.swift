//
//  HomeViewModel.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 2.09.2024.
//

import Foundation

//MARK: - HomeViewController
protocol HomeViewModelProtocol: AnyObject {
    func fetchNowPlayingMovies(page: Int?)
    var movies: MoviesResponse? {get}
}

//MARK: - HomeViewModelDelegate
protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

//MARK: - HomeViewModel
final class HomeViewModel {
    private var service = MoviesService()
    var movies: MoviesResponse? = nil
    weak var delegate: HomeViewModelDelegate?
}

//MARK: - HomeViewModelProtocol
extension HomeViewModel: HomeViewModelProtocol {
    func fetchNowPlayingMovies(page: Int?) {
        service.fetchNowPlayingMovies(page: page) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                movies = data
                delegate?.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

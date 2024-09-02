//
//  HomeViewModel.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 2.09.2024.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func fetchNowPlayingMovies(page: Int?)
    var movies: MoviesResponse? {get}
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

final class HomeViewModel {
    private var service = MoviesService()
    var movies: MoviesResponse? = nil
    var delegate: HomeViewModelDelegate?
}

extension HomeViewModel: HomeViewModelProtocol {
    func fetchNowPlayingMovies(page: Int?) {
        NetworkManager.shared.request(Router.nowPlaying(page: page), decodeToType: MoviesResponse.self) { [weak self] result in
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

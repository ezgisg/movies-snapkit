//
//  HomeViewController.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 2.09.2024.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let searchBar: UISearchBar = UISearchBar()
    
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchNowPlayingMovies(page: 1)
    }

}


private extension HomeViewController {
    final func setupUI() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        DispatchQueue.main.async {  [weak self] in
            guard let self else { return }
            view.backgroundColor = .purple
            tableView.backgroundColor = .blue
        }
        
        makeSearchBar()
        makeTableView()
    }
    
    final func makeSearchBar() {
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    final func makeTableView() {
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
        print(viewModel.movies)
    }
}

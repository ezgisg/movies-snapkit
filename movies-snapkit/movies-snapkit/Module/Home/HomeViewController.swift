//
//  HomeViewController.swift
//  movies-snapkit
//
//  Created by Ezgi Sümer Günaydın on 2.09.2024.
//

import Foundation
import UIKit
import SnapKit
import TinyConstraints

//MARK: - HomeViewController
class HomeViewController: UIViewController {
    
    //MARK: - UI Components
    let tableView: UITableView = UITableView()
    let searchBar: UISearchBar = UISearchBar()
    
    //MARK: - Module Components
    private var viewModel = HomeViewModel()

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchNowPlayingMovies(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

//MARK: - UI Setups
private extension HomeViewController {
    final func setupUI() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        DispatchQueue.main.async {  [weak self] in
            guard let self else { return }
            view.backgroundColor = .systemYellow
            tableView.backgroundColor = .white
        }
                
//        snapkitFunctions()
        tinyConstraintsFunctions()
    }
    
    final func snapkitFunctions() {
        makeSearchBarWithSnapkit()
        makeTableViewWithSnapkit()
    }
    
    final func tinyConstraintsFunctions() {
        makeSearchBarWithTiny()
        makeTableViewWithTiny()
    }
    
    final func makeSearchBarWithSnapkit() {
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    final func makeSearchBarWithTiny() {
        searchBar.layer.cornerRadius = 8
        searchBar.clipsToBounds = true
        searchBar.height(60)
        searchBar.leftToSuperview(offset: 10)
        searchBar.rightToSuperview(offset: -10)
        searchBar.topToSuperview(offset: 0, usingSafeArea: true)

    }
    
    final func makeTableViewWithSnapkit() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellWithClass: MovieCell.self)
        tableView.estimatedRowHeight = 200
        tableView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    final func makeTableViewWithTiny() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellWithClass: MovieCell.self)
        tableView.estimatedRowHeight = 200
        
        tableView.rightToSuperview()
        tableView.leftToSuperview()
        tableView.topToBottom(of: searchBar, offset: 10)
        tableView.bottomToSuperview(usingSafeArea: true)
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MovieCell.self)
        cell.configure(result: viewModel.movies?.results?[indexPath.row])
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieID = viewModel.movies?.results?[indexPath.row].id else { return }
        let detailViewModel = DetailViewModel(movieID: movieID)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}


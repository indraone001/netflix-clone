//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by deri indrawan on 08/06/22.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
  
  private var movies: [TopRatedMovie] = [TopRatedMovie]()
  
  private let discoverTable: UITableView = {
    let table = UITableView()
    table.register(UpcomingMoviesTableViewCell.self, forCellReuseIdentifier: UpcomingMoviesTableViewCell.identifier)
    return table
  }()
  
  private let searchController: UISearchController = {
    let controller = UISearchController(searchResultsController: SearchResultsViewController())
    controller.searchBar.placeholder = "Search for a movie or Tv show"
    controller.searchBar.searchBarStyle = .minimal
    return controller
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Search"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationItem.largeTitleDisplayMode = .always
    
    view.backgroundColor = .systemBackground
    
    view.addSubview(discoverTable)
    discoverTable.delegate = self
    discoverTable.dataSource = self
    navigationItem.searchController = searchController
    navigationController?.navigationBar.tintColor = .white
    
    fetchDiscoverMovies()
    searchController.searchResultsUpdater = self
  }
  
  func fetchDiscoverMovies() {
    APICaller.shared.getDiscoverMovies { [weak self] result in
      switch result {
      case .success(let movies):
        self?.movies = movies
        DispatchQueue.main.async {
          self?.discoverTable.reloadData()
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    discoverTable.frame = view.bounds
  }
  
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesTableViewCell.identifier, for: indexPath) as? UpcomingMoviesTableViewCell else {
      return UITableViewCell()
    }
    let movie = movies[indexPath.row]
    let model = UpcomingMovieViewModel(titleName: movie.originalName ?? movie.originalTitle ?? "uknown name", posterURL: movie.posterPath ?? "")
    cell.configure(with: model)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let query = searchBar.text,
          query.trimmingCharacters(in: .whitespaces).isEmpty,
          query.trimmingCharacters(in: .whitespaces).count >= 3,
          let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
    APICaller.shared.search(with: query) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let movies):
          print(movies)
          resultController.movies = movies
          resultController.searchResultCollectionView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

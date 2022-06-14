//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by deri indrawan on 08/06/22.
//

import UIKit

class UpcomingViewController: UIViewController {
  
  private var upcomingMovies: [UpcomingMovie] = [UpcomingMovie]()
  
  private let upcomingTable: UITableView = {
    let table = UITableView()
    table.register(UpcomingMoviesTableViewCell.self, forCellReuseIdentifier: UpcomingMoviesTableViewCell.identifier)
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "Upcoming"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationItem.largeTitleDisplayMode = .always
    
    view.addSubview(upcomingTable)
    upcomingTable.delegate = self
    upcomingTable.dataSource = self
    
    fetchUpcoming()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    upcomingTable.frame = view.bounds
  }
  
  private func fetchUpcoming() {
    APICaller.shared.getUpcoming { [weak self] result in
        switch result {
        case .success(let upcomingMovies):
          self?.upcomingMovies = upcomingMovies
          DispatchQueue.main.async {
            self?.upcomingTable.reloadData()
          }
        case.failure (let error):
          print(error.localizedDescription)
        }
    }
  }
  
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return upcomingMovies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesTableViewCell.identifier, for: indexPath) as? UpcomingMoviesTableViewCell else {
      return UITableViewCell()
    }
    let title = upcomingMovies[indexPath.row]
    cell.configure(with: UpcomingMovieViewModel(titleName: (title.originalTitle ?? title.originalName) ?? "unknown", posterURL: title.posterPath ?? "unknown"))
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
}

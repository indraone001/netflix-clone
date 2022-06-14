//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by deri indrawan on 14/06/22.
//

import UIKit

class SearchResultsViewController: UIViewController {
  
  public var movies: [TopRatedMovie] = [TopRatedMovie]()
  
  public let searchResultCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    view.addSubview(searchResultCollectionView)
    
    searchResultCollectionView.delegate = self
    searchResultCollectionView.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    searchResultCollectionView.frame = view.bounds
  }
  
}


extension SearchResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
    let movie = movies[indexPath.row]
    cell.configure(with: movie.posterPath ?? "")
    return cell
  }
  
  
}

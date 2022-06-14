//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by deri indrawan on 08/06/22.
//

import UIKit

private struct cellDataMovie {
  let posterPath: String?
}

class CollectionViewTableViewCell: UITableViewCell {

  static let identifier = "CollectionViewTableViewCell"
  
  private var data: [cellDataMovie] = [cellDataMovie]()
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 140, height: 200)
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    return collectionView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .systemPink
    contentView.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = contentView.bounds
  }
  
  public func configure(with movies: [Movie]) {
    for movie in movies {
      self.data.append(cellDataMovie(posterPath: movie.posterPath))
    }
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
  public func configure(with tvs: [Tv]) {
    for tv in tvs {
      self.data.append(cellDataMovie(posterPath: tv.posterPath))
    }
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
  public func configure(with upcomingMovies: [UpcomingMovie]) {
    for upcomingMovie in upcomingMovies {
      self.data.append(cellDataMovie(posterPath: upcomingMovie.posterPath))
    }
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }

  public func configure(with popularMovies: [PopularMovie]) {
    for popularMovie in popularMovies {
      self.data.append(cellDataMovie(posterPath: popularMovie.posterPath))
    }
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }

  public func configure(with topRatedMovies: [TopRatedMovie]) {
    for topRatedMovie in topRatedMovies {
      self.data.append(cellDataMovie(posterPath: topRatedMovie.posterPath))
    }
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
}


extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
    guard let model = data[indexPath.row].posterPath else {
      return UICollectionViewCell()
    }
    cell.configure(with: model)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
}

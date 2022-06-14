//
//  UpcomingMoviesTableViewCell.swift
//  Netflix Clone
//
//  Created by deri indrawan on 11/06/22.
//

import UIKit

class UpcomingMoviesTableViewCell: UITableViewCell {
  
  static let identifier = "UpcomingMoviesTableViewCell"
  
  private let playUpcomingMovieButton: UIButton = {
    let button = UIButton()
    let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
    button.setImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .white
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let upcomingMoviePosterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(upcomingMoviePosterImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(playUpcomingMovieButton)
    
    applyConstraint()
  }
  
  private func applyConstraint() {
    let upcomingMoviePosterImageViewConstraints = [
      upcomingMoviePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      upcomingMoviePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      upcomingMoviePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      upcomingMoviePosterImageView.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    let titleLabelConstraints = [
      titleLabel.leadingAnchor.constraint(equalTo: self.upcomingMoviePosterImageView.trailingAnchor, constant: 20),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]
    
    let playUpcomingMovieButtonConstraints = [
      playUpcomingMovieButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      playUpcomingMovieButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ]
    
    NSLayoutConstraint.activate(upcomingMoviePosterImageViewConstraints)
    NSLayoutConstraint.activate(titleLabelConstraints)
    NSLayoutConstraint.activate(playUpcomingMovieButtonConstraints)
  }
  
  public func configure(with model: UpcomingMovieViewModel) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
    upcomingMoviePosterImageView.sd_setImage(with: url, completed: nil)
    titleLabel.text = model.titleName
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
}

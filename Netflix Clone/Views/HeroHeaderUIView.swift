//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by deri indrawan on 09/06/22.
//

import UIKit

class HeroHeaderUIView: UIView {
  
  private let donwloadButton: UIButton = {
    let button = UIButton()
    button.setTitle("Download", for: .normal)
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let playButton: UIButton = {
    let button = UIButton()
    button.setTitle("Play", for: .normal)
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private let heroImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "HeroImage")
    return imageView
  }()
  
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [
      UIColor.clear.cgColor,
      UIColor.systemBackground.cgColor
    ]
    gradientLayer.frame = bounds
    gradientLayer.name = "gradientLayer"
    layer.addSublayer(gradientLayer)
  }
  
//  private func replaceGradient(oldLayer: CALayer) {
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = [
//      UIColor.clear.cgColor,
//      UIColor.systemBackground.cgColor
//    ]
//    gradientLayer.frame = bounds
//    gradientLayer.name = "gradientLayer"
//    layer.replaceSublayer(oldLayer, with: gradientLayer)
//  }
//
//  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//    super.traitCollectionDidChange(previousTraitCollection)
//    for layer in super.layer.sublayers! {
//      if layer.name == "gradientLayer" {
//        replaceGradient(oldLayer: layer)
//      }
//    }
//  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(heroImageView)
    addGradient()
    addSubview(playButton)
    addSubview(donwloadButton)
    applyConstraint()
  }
  
  func applyConstraint() {
    let playButtonConstraints = [
      playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
      playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      playButton.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    let downloadButtonConstraints = [
      donwloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
      donwloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      donwloadButton.widthAnchor.constraint(equalToConstant: 100)
    ]
    
    NSLayoutConstraint.activate(playButtonConstraints)
    NSLayoutConstraint.activate(downloadButtonConstraints)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    heroImageView.frame = bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}

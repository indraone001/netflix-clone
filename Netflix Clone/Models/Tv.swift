//
//  Tv.swift
//  Netflix Clone
//
//  Created by deri indrawan on 10/06/22.
//

import Foundation

struct TrendingTvResponse: Codable {
  let results: [Tv]
}

struct Tv: Codable {
  let id: Int
  let mediaType: String?
  let originalName: String?
  let originalTitle: String?
  let posterPath: String?
  let overview: String?
  let voteCount: Int
  let releaseDate: String?
  let voteAverage: Double
}

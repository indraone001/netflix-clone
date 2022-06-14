//
//  Movie.swift
//  Netflix Clone
//
//  Created by deri indrawan on 09/06/22.
//

import Foundation

struct TrendingMoviesResponse: Codable {
  let results: [Movie]
}

struct Movie: Codable {
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

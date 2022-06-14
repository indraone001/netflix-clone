//
//  APICaller.swift
//  Netflix Clone
//
//  Created by deri indrawan on 09/06/22.
//

import Foundation
import Alamofire

struct constans {
  static let API_KEY = "b6a8ca341c24a36dbf19fda86fc63538"
  static let baseURL = "https://api.themoviedb.org"
}

class APICaller {
  static let shared = APICaller()
  
  func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
    let url = "\(constans.baseURL)/3/trending/movie/day?api_key=\(constans.API_KEY)"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate(statusCode: 200..<300)
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(TrendingMoviesResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  func getTrendingTvs(completion: @escaping (Result<[Tv], Error>) -> Void) {
    let url = "\(constans.baseURL)/3/trending/tv/day?api_key=\(constans.API_KEY)"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate(statusCode: 200..<300)
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(TrendingTvResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  func getUpcoming(completion: @escaping (Result<[UpcomingMovie], Error>) -> Void) {
    let url = "\(constans.baseURL)/3/movie/upcoming?api_key=\(constans.API_KEY)&language=en-US&page=1"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate(statusCode: 200..<300)
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(UpcomingMovieResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  func getPopular(completion: @escaping (Result<[PopularMovie], Error>) -> Void){
    let url = "\(constans.baseURL)/3/movie/popular?api_key=\(constans.API_KEY)&language=en-US&page=1"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(PopularMovieResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  func getTopRated(completion: @escaping (Result<[TopRatedMovie], Error>) -> Void) {
    let url = "\(constans.baseURL)/3/movie/top_rated?api_key=\(constans.API_KEY)&language=en-US&page=1"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(TopRatedMovieResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }

  func getDiscoverMovies(completion: @escaping (Result<[TopRatedMovie], Error>) -> Void) {
    let url = "\(constans.baseURL)/3/discover/movie?api_key=\(constans.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(TopRatedMovieResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
  
  func search(with query: String, completion: @escaping (Result<[TopRatedMovie], Error>) -> Void) {
    guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
    let url = "\(constans.baseURL)/3/search/movie?api_key=\(constans.API_KEY)&query=\(query)"
    AF.request(url, method: .get, encoding: URLEncoding.default)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(TopRatedMovieResponse.self, from: data)
            completion(.success(result.results))
          } catch {
            completion(.failure(error))
          }
        case .failure(let error):
          completion(.failure(error))
        }
      }
  }
}



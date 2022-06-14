//
//  Extension.swift
//  Netflix Clone
//
//  Created by deri indrawan on 10/06/22.
//

import Foundation

extension String {
  func capitalizeFirstLetter() -> String {
    return self.prefix(1).uppercased() + self.lowercased().dropFirst()
  }
}

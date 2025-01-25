//
//  Item.swift
//  SampleInfiniteScroll
//
//  Created by shigeo on 2025/01/20.
//

import Foundation
import SwiftData

@Model
final class Item {
  var timestamp: Date
  var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd, HH:mm"
    return dateFormatter.string(from: timestamp)
  }
  
  init(timestamp: Date) {
    self.timestamp = timestamp
  }
}

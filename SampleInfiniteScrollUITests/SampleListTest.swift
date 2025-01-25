//
//  SampleListTest.swift
//  SampleInfiniteScrollUITests
//
//  Created by shigeo on 2025/01/25.
//

import XCTest

final class SampleListTest: XCTestCase {
  
  @MainActor
  func testAddItemTest() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    // launch the application with Bundle ID
    //      let bundleID = "com.example.SampleInfiniteScroll"
    //      let app = XCUIApplication(bundleIdentifier: bundleID)
    let app = XCUIApplication()
    app.launch()
    
    // clear list items
    let clearButton = app.buttons["Reset"]
    clearButton.tap()
    
    // setup the expectation
    let baseDate = Date()
    // make 50 items list: whose label is timestamp
    let dateLabelList = (0..<50).map { index in
      // add 1 minute for each item
      let date = Calendar.current.date(byAdding: .minute, value: index, to: baseDate)!
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd, HH:mm"
      return dateFormatter.string(from: date)
    }
    
    // tap the add button
    let addButton = app.buttons["Add Item"]
    
    // should see the add button
    XCTAssert(addButton.exists)
    
    // tap the add button
    addButton.tap()
    
    // should see loading indicator
    let loadingIndicator = app.images["progress.indicator"]
    XCTAssert(loadingIndicator.exists)
    
    // wait for 2 seconds
    try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    
    // should see the new item with the dateLabelList
    let newItem = app.staticTexts[dateLabelList.first!]
    
    // Use XCTAssert and related functions to verify your tests produce the correctzvcgnt
    XCTAssert(newItem.exists)
    
    // tap the reset button
    clearButton.tap()
    // should see no item
    XCTAssertFalse(newItem.exists)
  }
}

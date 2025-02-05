//
//  SampleInfiniteScrollApp.swift
//  SampleInfiniteScroll
//
//  Created by shigeo on 2025/01/20.
//

import SwiftUI
import SwiftData

@main
struct SampleInfiniteScrollApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

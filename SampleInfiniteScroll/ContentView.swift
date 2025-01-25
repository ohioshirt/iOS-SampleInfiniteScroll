//
//  ContentView.swift
//  SampleInfiniteScroll
//
//  Created by shigeo on 2025/01/20.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var isLoading = false

    var body: some View {
        NavigationSplitView {
            List {
              ForEach(items.sorted(by: { lhs, rhs in
                lhs.timestamp < rhs.timestamp
              })) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.formattedDate)
                    }
                    .disabled(isLoading)
                    // Trigger load on last item
                    .onAppear {
                        if item == items.last && !isLoading {
                            fetchNextData(item)
                        }
                    }
                }
                .onDelete(perform: deleteItems)

                if isLoading {
                    HStack {
                        Spacer()
                        Image(systemName: "progress.indicator")
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                  Button(
                    action: {
                    // reset the list
                    for item in items {
                      modelContext.delete(item)
                    }
                  }) {
                    Label("Reset", systemImage: "arrow.clockwise")
                  }
                  .disabled(isLoading)
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .disabled(isLoading)
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

  private func fetchNextData(_ lastItem: Item) {
      isLoading = true
      // dummy data fetch, you should replace this with your own data fetch
      // wait for 1 second to simulate network request
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation {
          // create a new item and insert it into the model context
          var date = lastItem.timestamp
          for _ in 0..<50 {
            date = Calendar.current.date(byAdding: .minute,
                                                 value: 1,
                                                 to: date)!
            let newItem = Item(timestamp: date)
            modelContext.insert(newItem)
          }
          try? modelContext.save()
          isLoading = false
        }
      }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

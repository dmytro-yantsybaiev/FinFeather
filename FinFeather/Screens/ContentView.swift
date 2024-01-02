//
//  ContentView.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 25.10.2023.
//

import SwiftUI
import Combine
import SwiftData
import FFDataSource
import FFDomain
import FFMVVM

struct ContentView: BaseView {

    @ObservedObject private(set) var viewModel: ContentViewModel

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .onAppear {
            fetchItems()
        }
    }

    init(_ viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }

    private func fetchItems() {
        viewModel.fetchItemsSubject.send()
    }

    private func addItem() {
        withAnimation {
            viewModel.addItemSubject.send(Item())
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                guard let item = viewModel.items[safe: index] else { return }
                viewModel.removeItemSubject.send(item)
            }
        }
    }
}

#Preview {
    ContentView(ContentViewModel())
        .modelContainer(for: Item.self, inMemory: true)
}

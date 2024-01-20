//
//  ViewItems.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 25.10.2023.
//

import SwiftUI
import Combine
import SwiftData
import FFDataSource
import ComposableArchitecture

struct ViewItems: View {

    @State private var store: StoreOf<FeatureItems>
    @ObservedObject private var viewStore: ViewStoreOf<FeatureItems>

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewStore.items) { item in
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

    init(_ store: StoreOf<FeatureItems>) {
        self.store = store
        viewStore = ViewStore(store, observe: { $0 })
    }

    private func addItem() {
        withAnimation {
            _ = viewStore.send(.didTapAddItemButton)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                viewStore.send(.didDeleteItemAt(index))
            }
        }
    }

    private func fetchItems() {
        viewStore.send(.onAppear)
    }
}

#Preview {
    let store = Store(initialState: FeatureItems.State()) { FeatureItems() }
    return ViewItems(store)
        .modelContainer(for: Item.self, inMemory: true)
}

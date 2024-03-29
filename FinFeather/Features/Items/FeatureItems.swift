//
//  FeatureItems.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 17.01.2024.
//

import Foundation
import SwiftUI
import SwiftData
import Combine
import FFDataSource
import UseCaseItem
import ComposableArchitecture
import Resolver

@Reducer
struct FeatureItems {

    struct State: Equatable {
        var items = [Item]()
    }

    enum Action {
        case onAppear
        case didTapAddItemButton
        case didDeleteItemAt(_ index: Int)
        case didReceiveAddItemResponse(_ result: Result<Item, Error>)
        case didReceiveRemoveItemResponse(_ result: Result<Item, Error>)
        case didReceiveFetchItemsResponse(_ result: Result<[Item], Error>)
    }

    @Dependency(\.useCaseItem) private var useCaseItem: UseCaseItem

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .publisher {
                    useCaseItem
                        .fetch(FetchDescriptor<Item>(sortBy: [SortDescriptor(\.timestamp)]))
                        .map { .didReceiveFetchItemsResponse(.success($0)) }
                        .catch { Just(.didReceiveFetchItemsResponse(.failure($0))) }
                }

            case .didTapAddItemButton:
                return .publisher {
                    useCaseItem
                        .insert(Item())
                        .map { .didReceiveAddItemResponse(.success($0)) }
                        .catch { Just(.didReceiveAddItemResponse(.failure($0))) }
                }

            case let .didDeleteItemAt(index):
                return .publisher { [items = state.items] in
                    useCaseItem
                        .delete(items[index])
                        .map { .didReceiveRemoveItemResponse(.success($0)) }
                        .catch { Just(.didReceiveRemoveItemResponse(.failure($0))) }
                }

            case let .didReceiveAddItemResponse(result):
                guard case let .success(item) = result else {
                    return .none
                }
                state.items.append(item)
                return .none

            case let .didReceiveRemoveItemResponse(result):
                guard case let .success(item) = result,
                      let index = state.items.firstIndex(of: item) else {
                    return .none
                }
                state.items.remove(at: index)
                return.none

            case let .didReceiveFetchItemsResponse(result):
                guard case let .success(items) = result else {
                    return .none
                }
                state.items = items
                return .none
            }
        }
    }
}

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

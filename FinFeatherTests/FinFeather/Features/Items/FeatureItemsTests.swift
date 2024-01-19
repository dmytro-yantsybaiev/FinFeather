//
//  FeatureItemsTests.swift
//  FinFeatherTests
//
//  Created by Dmytro Yantsybaiev on 18.01.2024.
//

@testable import FinFeather

import XCTest
import Combine
import FFDataSource
import UseCaseItem
import ComposableArchitecture
import Resolver

@MainActor
final class FeatureItemsTests: XCTestCase {

    func test_didTapAddItemButton_action() async {
        let item = Item()
        let store = TestStore(initialState: FeatureItems.State()) {
            FeatureItems()
        } withDependencies: {
            $0.useCaseItem = UseCaseItem.mock
            $0.useCaseItem.insert = { _ in Deferred { Future { $0(.success(item)) } }.eraseToAnyPublisher() }
        }

        await store.send(.didTapAddItemButton)
        await store.receive(\.didReceiveAddItemResponse) { $0.items.append(item) }
    }

    func test_didDeleteItemAtIndex_action() async {
        let itemIndex = 0
        let items = [Item(), Item(), Item()]
        let store = TestStore(initialState: FeatureItems.State(items: items)) {
            FeatureItems()
        } withDependencies: {
            $0.useCaseItem = UseCaseItem.mock
            $0.useCaseItem.delete = { item in Deferred { Future { $0(.success(item)) } }.eraseToAnyPublisher() }
        }

        await store.send(.didDeleteItemAt(itemIndex))
        await store.receive(\.didReceiveRemoveItemResponse) { $0.items.remove(at: itemIndex) }
    }

    func test_onAppear_action() async {
        let items = [Item(), Item(), Item()]
        let store = TestStore(initialState: FeatureItems.State()) {
            FeatureItems()
        } withDependencies: {
            $0.useCaseItem = UseCaseItem.mock
            $0.useCaseItem.fetch = { _ in Deferred { Future { $0(.success(items)) } }.eraseToAnyPublisher() }
        }

        await store.send(.onAppear)
        await store.receive(\.didReceiveFetchItemsResponse) { $0.items = items }
    }
}

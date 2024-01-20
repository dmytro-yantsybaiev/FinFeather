//
//  UseCaseItem+Live.swift
//  
//
//  Created by Dmytro Yantsybaiev on 19.01.2024.
//

import Foundation
import Combine
import SwiftData
import FFDataSource
import UseCaseItem
import ComposableUseCase
import ComposableRepositories

private let subscribeDispatcher = DispatchQueue.global()
private let receiveDispatcher = DispatchQueue.main

extension UseCaseItem {

    public static func live(repository: RepositorySwiftData<Item>) -> Self {
        Self(
            insert: useCaseInsertItem(repository).execute,
            delete: useCaseDeleteItem(repository).execute,
            fetch: useCaseDetchItems(repository).execute
        )
    }

    private static func useCaseInsertItem(_ repository: RepositorySwiftData<Item>) -> ComposableUseCase<Item, Item> {
        ComposableUseCase<Item, Item> { item in
            do {
                try repository.insert(item)
                return Deferred { Future { $0(.success(item)) } }
                    .subscribe(on: subscribeDispatcher)
                    .receive(on: receiveDispatcher)
                    .eraseToAnyPublisher()
            } catch {
                return Deferred { Future { $0(.failure(error)) } }
                    .eraseToAnyPublisher()
            }
        }
    }

    private static func useCaseDeleteItem(_ repository: RepositorySwiftData<Item>) -> ComposableUseCase<Item, Item> {
        ComposableUseCase<Item, Item> { item in
            do {
                try repository.delete(item)
                return Deferred { Future { $0(.success(item)) } }
                    .subscribe(on: subscribeDispatcher)
                    .receive(on: receiveDispatcher)
                    .eraseToAnyPublisher()
            } catch {
                return Deferred { Future { $0(.failure(error)) } }
                    .eraseToAnyPublisher()
            }
        }
    }

    private static func useCaseDetchItems(_ repository: RepositorySwiftData<Item>) -> ComposableUseCase<[Item], FetchDescriptor<Item>> {
        ComposableUseCase<[Item], FetchDescriptor<Item>> { descriptor in
            do {
                let items: [Item] = try repository.fetch(descriptor)
                return Deferred { Future { $0(.success(items)) } }
                    .subscribe(on: subscribeDispatcher)
                    .receive(on: receiveDispatcher)
                    .eraseToAnyPublisher()
            } catch {
                return Deferred { Future { $0(.failure(error)) } }
                    .eraseToAnyPublisher()
            }
        }
    }
}

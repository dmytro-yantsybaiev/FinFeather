//
//  UseCaseItem+Interface.swift
//
//
//  Created by Dmytro Yantsybaiev on 19.01.2024.
//

import Combine
import SwiftData
import FFDataSource

public struct UseCaseItem {

    public var insert: (Item) -> AnyPublisher<Item, Error>
    public var delete: (Item) -> AnyPublisher<Item, Error>
    public var fetch: (FetchDescriptor<Item>) -> AnyPublisher<[Item], Error>

    public init(
        insert: @escaping (Item) -> AnyPublisher<Item, Error>,
        delete: @escaping (Item) -> AnyPublisher<Item, Error>,
        fetch: @escaping (FetchDescriptor<Item>) -> AnyPublisher<[Item], Error>
    ) {
        self.insert = insert
        self.delete = delete
        self.fetch = fetch
    }
}

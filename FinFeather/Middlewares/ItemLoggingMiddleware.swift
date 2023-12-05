//
//  ItemLoggingMiddleware.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 08.11.2023.
//

import Combine
import OSLog

final class ItemLoggingMiddleware: MiddlewareType {

    private lazy var logger = Logger(
        subsystem: Bundle(for: Self.self).bundleIdentifier.orEmpty,
        category: "FinFeather"
    )

    func apply(_ action: ItemAction) -> AnyPublisher<ItemAction, Never> {
        switch action {
        case .add(let item):
            logger.info("Item \(item.timestamp) was added")
            return Just(.add(item)).eraseToAnyPublisher()
        case .remove(let item):
            logger.info("Item \(item.timestamp) was removed")
            return Just(.remove(item)).eraseToAnyPublisher()
        case .update(let items):
            logger.info("Items \(items) were added")
            return Just(.update(items)).eraseToAnyPublisher()
        case .fetch:
            logger.info("Items were fetched")
            return Just(.fetch).eraseToAnyPublisher()
        }
    }
}

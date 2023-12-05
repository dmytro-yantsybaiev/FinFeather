//
//  ItemMiddleware.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

import Combine
import SwiftUI
import FFDomain
import FFDataSource

final class ItemMiddleware: MiddlewareType {

    @Injected private var addItemUseCase: AddItemUseCase
    @Injected private var removeItemUseCase: RemoveItemUseCase
    @Injected private var fetchItemsUseCase: FetchItemsUseCase

    func apply(_ action: ItemAction) -> AnyPublisher<ItemAction, Never> {
        switch action {
        case .add(let item):
            return addItemUseCase.execute(with: item)
                .map { .add($0) }
                .catch { _ in Just(.add(item)) }
                .eraseToAnyPublisher()
        case .remove(let item):
            return removeItemUseCase.execute(with: item)
                .map { .remove($0) }
                .catch { _ in Just(.remove(item)) }
                .eraseToAnyPublisher()
        case .fetch:
            return fetchItemsUseCase.execute()
                .map { .update($0) }
                .catch { _ in Just(.update(.empty)) }
                .eraseToAnyPublisher()
        default:
            return Just(action).eraseToAnyPublisher()
        }
    }
}

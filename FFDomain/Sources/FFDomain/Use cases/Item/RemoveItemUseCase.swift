//
//  RemoveItemUseCase.swift
//
//
//  Created by Dmytro Yantsybaiev on 08.11.2023.
//

import Combine
import FFDataSource

public final class RemoveItemUseCase: BaseUseCase<Item, Item> {

    private let repository: SwiftDataRepository

    public init(repository: SwiftDataRepository) {
        self.repository = repository
    }

    override func build(with item: Item?) -> AnyPublisher<Item, Error> {
        guard let item else {
            return .error(NetworkError.missingParameters)
        }
        repository.delete(item)
        return .just(item)
    }
}

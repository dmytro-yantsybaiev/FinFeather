//
//  FetchItemsUseCase.swift
//
//
//  Created by Dmytro Yantsybaiev on 08.11.2023.
//

import Combine
import FFDataSource

public final class FetchItemsUseCase: BaseUseCase<[Item], Void> {

    private let repository: SwiftDataRepository

    public init(repository: SwiftDataRepository) {
        self.repository = repository
    }

    override func build(with parameters: Void? = nil) -> AnyPublisher<[Item], Error> {
        guard let items: [Item] = repository.fetch() else {
            return .error(NetworkError.fetchDataFailed)
        }
        return .just(items)
    }
}

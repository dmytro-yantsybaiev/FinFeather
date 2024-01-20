//
//  ItemUseCases+Injection.swift.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 17.01.2024.
//

import Combine
import FFDataSource
import UseCaseItem
import UseCaseItemLive
import ComposableArchitecture
import Resolver

extension UseCaseItem: DependencyKey {

    public static let liveValue = Self.live(repository: Resolver.resolve())

    public static let testValue = Self.mock

    public static let previewValue = {
        let items = Array(repeating: Item(), count: 5)
        var useCase = Self.mock
        useCase.fetch = { _ in Deferred { Future { $0(.success(items)) } }.eraseToAnyPublisher() }
        return useCase
    }()
}

extension DependencyValues {

    var useCaseItem: UseCaseItem {
        get { self[UseCaseItem.self] }
        set { self[UseCaseItem.self] = newValue }
    }
}

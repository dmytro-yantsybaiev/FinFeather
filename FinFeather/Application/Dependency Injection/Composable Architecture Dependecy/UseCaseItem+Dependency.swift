//
//  ItemUseCases+Injection.swift.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 17.01.2024.
//

import FFDataSource
import UseCaseItem
import UseCaseItemLive
import ComposableArchitecture

extension UseCaseItem: DependencyKey {

    public static let liveValue = Self.live(repository: Dependency(\.swiftDataRepository).wrappedValue)
}

extension DependencyValues {

    var useCaseItem: UseCaseItem {
        get { self[UseCaseItem.self] }
        set { self[UseCaseItem.self] = newValue }
    }
}

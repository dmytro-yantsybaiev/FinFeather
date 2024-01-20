//
//  Repository+Dependecy.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 19.01.2024.
//

import FFDataSource
import ComposableRepositories
import ComposableRepositoriesLive
import ComposableArchitecture
import Resolver

extension SwiftDataRepository: DependencyKey {

    @MainActor
    public static var liveValue: SwiftDataRepository<Item> {
        SwiftDataRepository<Item>.live(modelContainer: Resolver.resolve())
    }
}

extension DependencyValues {

    var swiftDataRepository: SwiftDataRepository<Item> {
        get { self[SwiftDataRepository<Item>.self] }
        set { self[SwiftDataRepository<Item>.self] = newValue }
    }
}

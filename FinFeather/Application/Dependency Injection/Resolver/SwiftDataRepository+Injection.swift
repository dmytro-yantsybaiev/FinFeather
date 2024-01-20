//
//  SwiftDataRepository+Injection.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 20.01.2024.
//

import FFDataSource
import ComposableRepositories
import ComposableRepositoriesLive
import Resolver

@MainActor
extension Resolver {

    static func registerRepositorySwiftDataItem() {
        register { RepositorySwiftData<Item>.live(modelContainer: Resolver.resolve()) }
            .scope(.shared)
    }
}


//
//  App+Injection.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 17.01.2024.
//

import ComposableArchitecture
import Resolver

extension Resolver: ResolverRegistering {

    @MainActor
    public static func registerAllServices() {

        // Application
        registerModelContainer()

        // Repositories
        registerRepositorySwiftDataItem()
    }
}

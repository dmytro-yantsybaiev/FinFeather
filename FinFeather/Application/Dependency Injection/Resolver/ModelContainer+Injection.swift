//
//  ModelContainer+Injection.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 17.01.2024.
//

import SwiftData
import FFDataSource
import Resolver

@MainActor
extension Resolver {

    static func registerModelContainer() {
        register {
            do {
                let schema = Schema([
                    Item.self,
                ])
                let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError()
            }
        }
        .scope(.application)
    }
}

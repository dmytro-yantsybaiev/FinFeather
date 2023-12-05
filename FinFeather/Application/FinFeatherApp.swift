//
//  FinFeatherApp.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 25.10.2023.
//

import SwiftUI
import FFDomain

@main
struct FinFeatherApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        InjectionBundle.load { resolver in

            // Common
            resolver.single { SwiftDataRepository() }

            // Use Cases
            resolver.factory { AddItemUseCase(repository: resolver.resolve()) }
            resolver.factory { RemoveItemUseCase(repository: resolver.resolve()) }
            resolver.factory { FetchItemsUseCase(repository: resolver.resolve()) }

            // Stores
            resolver.single {
                Store<AppState, ItemAction>(AppState(), ItemReducer()) {
                    ItemLoggingMiddleware().eraseToAnyMiddleware()
                    ItemMiddleware().eraseToAnyMiddleware()
                }
            }
        }
    }
}

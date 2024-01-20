//
//  FinFeatherApp.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 25.10.2023.
//

import SwiftUI
import ComposableArchitecture
import Resolver

@main
struct FinFeatherApp: App {

    private static let store: StoreOf<FeatureItems> = Resolver.resolve()

    var body: some Scene {
        WindowGroup {
            ViewItems(FinFeatherApp.store)
        }
    }
}

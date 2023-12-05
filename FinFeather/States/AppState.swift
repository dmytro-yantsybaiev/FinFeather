//
//  AppState.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 30.10.2023.
//

import SwiftUI
import SwiftData
import FFDataSource

struct AppState {

    let items: [Item]
    var error: Error?

    init(items: [Item]) {
        self.items = items
    }

    init() {
        items = [Item]()
    }
}

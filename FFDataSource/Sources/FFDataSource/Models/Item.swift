//
//  Item.swift
//  
//
//  Created by Dmytro Yantsybaiev on 28.10.2023.
//

import Foundation
import SwiftData

@Model
public final class Item {

    public private(set) var timestamp = Date()

    public init(timestamp: Date) {
        self.timestamp = timestamp
    }

    public convenience init() {
        self.init(timestamp: Date())
    }
}

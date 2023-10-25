//
//  Item.swift
//  FinFeather
//
//  Created by dyantsybaiev on 25.10.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
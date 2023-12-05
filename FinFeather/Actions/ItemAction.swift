//
//  ItemAction.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

import FFDataSource

enum ItemAction {
    case add(Item)
    case remove(Item)
    case update([Item])
    case fetch
}

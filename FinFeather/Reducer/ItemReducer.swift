//
//  ItemReducer.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

final class ItemReducer: ReducerType {

    func reduce(_ state: AppState, _ action: ItemAction) -> AppState {
        switch action {
        case .add(let item):
            var items = state.items
            items.append(item)
            return State(items: items)
        case .remove(let item):
            guard let itemIndex = state.items.firstIndex(of: item) else {
                return state
            }
            var items = state.items
            items.remove(at: itemIndex)
            return State(items: items)
        case .update(let items):
            return State(items: items)
        case .fetch:
            return state
        }
    }
}

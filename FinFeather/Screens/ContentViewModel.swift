//
//  ContentViewModel.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 02.01.2024.
//

import SwiftUI
import Combine
import FFDataSource
import FFDomain
import FFMVVM

final class ContentViewModel: ViewModelType {

    @Published private(set) var items = [Item]()

    private(set) var fetchItemsSubject = PassthroughSubject<Void, Never>()
    private(set) var addItemSubject = PassthroughSubject<Item, Never>()
    private(set) var removeItemSubject = PassthroughSubject<Item, Never>()

    @Injected private var fetchItemsUseCase: FetchItemsUseCase
    @Injected private var addItemUseCase: AddItemUseCase
    @Injected private var removeItemUseCase: RemoveItemUseCase

    private var cancellable = Set<AnyCancellable>()

    private func handleFetchItems(_ result: Result<[Item], Error>) {
        guard case .success(let items) = result else {
            return
        }
        self.items = items
    }

    private func handleAddItem(_ result: Result<Item, Error>) {
        guard case .success(let item) = result else {
            return
        }
        items.append(item)
    }

    private func handleRemoveItem(_ result: Result<Item, Error>) {
        guard case .success(let item) = result, let itemIndex = items.firstIndex(of: item) else {
            return
        }
        items.remove(at: itemIndex)
    }
}

//
//  AnyMiddleware.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

import Combine

final class AnyMiddleware<Action>: MiddlewareType {

    private let wrappedApply: (Action) -> AnyPublisher<Action, Never>

    init<M: MiddlewareType>(_ middleware: M) where M.Action == Action {
        wrappedApply = middleware.apply
    }

    func apply(_ action: Action) -> AnyPublisher<Action, Never> {
        wrappedApply(action)
    }
}

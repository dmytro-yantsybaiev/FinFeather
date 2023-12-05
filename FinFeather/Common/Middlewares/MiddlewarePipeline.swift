//
//  MiddlewarePipeline.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

import Combine

final class MiddlewarePipeline<Action>: MiddlewareType {

    private let middlewares: [AnyMiddleware<Action>]

    init(_ middlewares: [AnyMiddleware<Action>]) {
        self.middlewares = middlewares
    }

    func apply(_ action: Action) -> AnyPublisher<Action, Never> {
        middlewares.reduce(Just(action).eraseToAnyPublisher()) { current, middleware in
            current.flatMap { middleware.apply($0) }.eraseToAnyPublisher()
        }
    }
}

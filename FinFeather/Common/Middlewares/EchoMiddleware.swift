//
//  EchoMiddleware.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

import Combine

final class EchoMiddleware<Action>: MiddlewareType {

    func apply(_ action: Action) -> AnyPublisher<Action, Never> {
        Just(action).eraseToAnyPublisher()
    }
}

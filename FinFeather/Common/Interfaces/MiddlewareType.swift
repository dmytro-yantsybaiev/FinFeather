//
//  MiddlewareType.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

import Combine

protocol MiddlewareType: AnyObject {

    associatedtype Action

    func apply(_ action: Action) -> AnyPublisher<Action, Never>
}

extension MiddlewareType {

    func eraseToAnyMiddleware() -> AnyMiddleware<Action> {
        self as? AnyMiddleware ?? AnyMiddleware(self)
    }
}

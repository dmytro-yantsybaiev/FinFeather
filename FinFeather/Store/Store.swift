//
//  Store.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 30.10.2023.
//

import Foundation
import Combine

final class Store<State, Action>: ObservableObject {

    @Published private(set) var state: State

    private let middleware: AnyMiddleware<Action>
    private let reducer: AnyReducer<State, Action>

    private var cancellable = Set<AnyCancellable>()

    init<Middleware: MiddlewareType, Reducer: ReducerType>(
        _ state: State,
        _ reducer: Reducer,
        @MiddlewareBuilder<Action> _ middleware: () -> Middleware
    ) where Reducer.State == State, Reducer.Action == Action, Middleware.Action == Action {
        self.state = state
        self.reducer = reducer.eraseToAnyReducer()
        self.middleware = middleware().eraseToAnyMiddleware()
    }

    convenience init<Reducer: ReducerType>(
        _ state: State, 
        _ reducer: Reducer
    ) where Reducer.State == State, Reducer.Action == Action {
        self.init(state, reducer) { EchoMiddleware<Action>().eraseToAnyMiddleware() }
    }

    func dispatch(_ action: Action) {
        middleware.apply(action)
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] action in
                state = reducer.reduce(state, action)
            }
            .store(in: &cancellable)
    }
}

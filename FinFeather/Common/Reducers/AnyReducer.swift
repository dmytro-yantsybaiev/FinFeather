//
//  AnyReducer.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

final class AnyReducer<State, Action>: ReducerType {

    private let wrappedReduce: (State, Action) -> State

    init<R: ReducerType>(_ reducer: R) where R.State == State, R.Action == Action {
        wrappedReduce = reducer.reduce
    }

    func reduce(_ state: State, _ action: Action) -> State {
        wrappedReduce(state, action)
    }
}

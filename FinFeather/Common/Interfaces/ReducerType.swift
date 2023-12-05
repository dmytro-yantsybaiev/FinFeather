//
//  ReducerType.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 31.10.2023.
//

protocol ReducerType: AnyObject {

    associatedtype State
    associatedtype Action

    func reduce(_ state: State, _ action: Action) -> State
}

extension ReducerType {

    func eraseToAnyReducer() -> AnyReducer<State, Action> {
        self as? AnyReducer ?? AnyReducer(self)
    }
}

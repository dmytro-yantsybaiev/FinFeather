//
//  BaseUseCase.swift
//
//
//  Created by Dmytro Yantsybaiev on 08.11.2023.
//

import Foundation
import Combine

public class BaseUseCase<Model, Parameters> {

    private let subscribeDispatcher: DispatchQueue
    private let receiveDispatcher: DispatchQueue

    public init(
        subscribeOn: DispatchQueue = .global(),
        receiveOn: DispatchQueue = .main
    ) {
        subscribeDispatcher = subscribeOn
        receiveDispatcher = receiveOn
    }

    public func execute(with parameters: Parameters? = nil) -> AnyPublisher<Model, Error> {
        build(with: parameters)
            .subscribe(on: subscribeDispatcher)
            .receive(on: receiveDispatcher)
            .eraseToAnyPublisher()
    }

    func build(with parameters: Parameters? = nil) -> AnyPublisher<Model, Error> {
        Empty().eraseToAnyPublisher()
    }
}

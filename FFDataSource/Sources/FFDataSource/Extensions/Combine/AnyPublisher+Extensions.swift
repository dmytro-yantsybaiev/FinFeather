//
//  AnyPublisher+Extensions.swift
//
//
//  Created by Dmytro Yantsybaiev on 08.11.2023.
//

import Combine

public extension AnyPublisher {

    static func just<T>(_ output: T) -> AnyPublisher<T, Error> {
        Future { $0(.success(output)) }.eraseToAnyPublisher()
    }

    static func error<T>(_ error: Error) -> AnyPublisher<T, Error> {
        Future { $0(.failure(error)) }.eraseToAnyPublisher()
    }
}

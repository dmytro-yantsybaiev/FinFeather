//
//  Publisher+Extensions.swift
//  
//
//  Created by Dmytro Yantsybaiev on 02.01.2024.
//

import Combine

public extension Publisher {

    func sink(result: @escaping (Result<Self.Output, Self.Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let failure):
                result(.failure(failure))
            default:
                break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}

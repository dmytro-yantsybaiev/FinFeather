//
//  UseCaseItem+Mock.swift
//
//
//  Created by Dmytro Yantsybaiev on 19.01.2024.
//

import Combine

extension UseCaseItem {

    public static let mock = Self(
        insert: { item in Deferred { Future { $0(.success(item)) } }.eraseToAnyPublisher() },
        delete: { item in Deferred { Future { $0(.success(item)) } }.eraseToAnyPublisher() },
        fetch: { _ in Deferred { Future { $0(.success([])) } }.eraseToAnyPublisher() }
    )
}

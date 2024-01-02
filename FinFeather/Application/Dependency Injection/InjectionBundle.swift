//
//  InjectionBundle.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 07.11.2023.
//

final class InjectionBundle {

    static func load(_ resolver: (DependencyResolver) -> Void) {
        resolver(DependencyResolver.shared)
    }
}

//
//  Injected.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 07.11.2023.
//

@propertyWrapper
struct Injected<T> {

    var wrappedValue: T {
        get { value }
        set { value = newValue }
    }

    private var value: T

    init() {
        value = DependencyResolver.shared.resolve()
    }
}

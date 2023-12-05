//
//  InjectedObject.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 07.11.2023.
//

import SwiftUI

@propertyWrapper
struct InjectedObservable<T>: DynamicProperty where T: ObservableObject {

    var wrappedValue: T {
        get { value }
        set { value = newValue}
    }

    @ObservedObject
    private var value: T

    init() {
        value = DependencyResolver.shared.resolve()
    }
}

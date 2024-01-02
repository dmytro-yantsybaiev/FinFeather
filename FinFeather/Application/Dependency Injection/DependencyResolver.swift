//
//  DependencyResolver.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 07.11.2023.
//

private typealias FactoryCallback = () -> Any

final class DependencyResolver {

    static let shared = DependencyResolver()

    private var singles = [String: Any]()
    private var factories = [String: FactoryCallback]()

    func single<T>(_ resolver: () -> T) {
        singles[String(describing: T.self)] = resolver()
    }

    func factory<T>(_ resolver: @escaping () -> T) {
        factories[String(describing: T.self)] = resolver
    }

    func resolve<T>() -> T {
        let key = String(describing: T.self)

        if let single = singles[key] as? T {
            return single
        }

        if let factory = factories[key]?() as? T {
            return factory
        }

        fatalError("Dependency \(key) not registered")
    }
}

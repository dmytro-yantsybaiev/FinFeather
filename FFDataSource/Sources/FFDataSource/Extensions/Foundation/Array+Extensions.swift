//
//  Array+Extensions.swift
//
//
//  Created by Dmytro Yantsybaiev on 08.11.2023.
//

public extension Array {

    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    static var empty: Self {
        []
    }
}

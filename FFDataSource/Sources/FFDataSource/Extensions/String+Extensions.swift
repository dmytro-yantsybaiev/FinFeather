//
//  String+Extensions.swift
//  
//
//  Created by Dmytro Yantsybaiev on 28.10.2023.
//

public extension String {

    static var empty: Self {
        ""
    }
}

public extension Optional where Wrapped == String {

    /// Unwraps the optional and returns empty string if self is nil.
    var orEmpty: String {
        self ?? .empty
    }
}

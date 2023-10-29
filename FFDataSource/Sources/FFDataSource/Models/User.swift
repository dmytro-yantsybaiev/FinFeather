//
//  User.swift
//
//
//  Created by Dmytro Yantsybaiev on 28.10.2023.
//

import Foundation
import SwiftData

public final class User {

    public let name: String
    public let surname: String

    public init(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }
}

extension User: Codable {

    private enum CodingKeys: CodingKey {
        case name
        case surname
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let surname = try container.decode(String.self, forKey: .surname)
        self.init(name: name, surname: surname)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(surname, forKey: .surname)
    }
}

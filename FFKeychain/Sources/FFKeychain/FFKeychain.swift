//
//  FFKeychain.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 28.10.2023.
//

import Foundation
import OSLog
import FFDataSource

public final class FFKeychain {

    public enum Key: String, CaseIterable {
        case test
        case user
    }

    public static let shared = FFKeychain()

    private lazy var logger = Logger(
        subsystem: Bundle(for: Self.self).bundleIdentifier.orEmpty,
        category: "FFKeychain"
    )

    @discardableResult
    public func save<Item: Codable>(_ item: Item, key: Key) -> Item? {
        guard let data: Data = try? JSONEncoder.shared.encode(item) else {
            logger.fault("Failed to encode the item `\(Item.self)` for the key `\(key.rawValue)`.")
            return nil
        }

        let attributes: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.account,
            kSecAttrLabel: key.rawValue,
            kSecValueData: data,
        ] as CFDictionary

        let status: OSStatus = SecItemAdd(attributes, nil)

        if status == errSecSuccess {
            logger.info("The keychain item `\(Item.self)` for the key `\(key.rawValue)` was successfully saved.")
            return item
        }

        if status == errSecDuplicateItem {
            return update(item, key: key)
        }

        let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String).orEmpty
        logger.fault("Failed to save the keychain item `\(Item.self)` for the key `\(key.rawValue)`. \(errorMessage)")
        return nil
    }

    @discardableResult
    public func loadItem<Item: Codable>(key: Key) -> Item? {
        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.account,
            kSecAttrLabel: key.rawValue,
            kSecReturnData: true,
        ] as CFDictionary

        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String).orEmpty
            logger.fault("Failed to load the keychain item `\(Item.self)` for the key `\(key.rawValue)`. \(errorMessage)")
            return nil
        }

        guard let data: Data = result as? Data else {
            logger.fault("Failed to parse the found result as `Data` for the key `\(key.rawValue)`.")
            return nil
        }

        guard let item: Item = try? JSONDecoder.shared.decode(Item.self, from: data) else {
            logger.fault("Failed to decode the item's data as `\(Item.self)` for the key `\(key.rawValue)`.")
            return nil
        }

        logger.info("The keychain item `\(Item.self)` for the key `\(key.rawValue)` was successfully loaded.")
        return item
    }

    public func deleteItem(key: Key) {
        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.account,
            kSecAttrLabel: key.rawValue,
        ] as CFDictionary

        let status: OSStatus = SecItemDelete(query)

        guard status == errSecSuccess else {
            let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String).orEmpty
            logger.fault("Failed to delete the keychain item for the key `\(key.rawValue)`. \(errorMessage)")
            return
        }

        logger.info("The keychain item for the key `\(key.rawValue)` was successfully deleted.")
    }

    public func clear() {
        Key.allCases.forEach { Self.shared.deleteItem(key: $0) }
    }

    private func update<Item: Codable>(_ item: Item, key: Key) -> Item? {
        guard let data: Data = try? JSONEncoder.shared.encode(item) else {
            logger.fault("Failed to encode the item `\(Item.self)` for the key `\(key.rawValue)`.")
            return nil
        }

        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.account,
            kSecAttrLabel: key.rawValue,
        ] as CFDictionary

        let attributesToUpdate: CFDictionary = [kSecValueData: data] as CFDictionary
        let status: OSStatus = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else {
            let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String).orEmpty
            logger.fault("Failed to update the keychain item `\(Item.self)` for the key `\(key.rawValue)`. \(errorMessage)")
            return nil
        }

        logger.info("The keychain item `\(Item.self)` for the key `\(key.rawValue)` was successfully updated.")
        return item
    }
}

private extension FFKeychain.Key {

    var account: String {
        switch self {
        case .test:
            .empty
        case .user:
            Bundle(for: User.self).bundleIdentifier.orEmpty
        }
    }
}

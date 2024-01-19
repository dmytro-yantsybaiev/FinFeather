//
//  FFKeychain.swift
//  FinFeather
//
//  Created by Dmytro Yantsybaiev on 28.10.2023.
//

import Foundation
import OSLog

public final class FFKeychain {

    public static let shared = FFKeychain()

    private lazy var logger = Logger(
        subsystem: Bundle(for: Self.self).bundleIdentifier ?? "",
        category: "FFKeychain"
    )

    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()

    private init() {}

    @discardableResult
    public func save<Item: Codable>(_ item: Item, key: String) -> Item? {
        guard let data: Data = try? jsonEncoder.encode(item) else {
            logger.fault("🔑🔒: Failed to encode the item `\(Item.self)` for the key `\(key)`.")
            return nil
        }

        let attributes: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrLabel: key,
            kSecValueData: data,
        ] as CFDictionary

        let status: OSStatus = SecItemAdd(attributes, nil)

        if status == errSecSuccess {
            logger.info("🔑🔒: The keychain item `\(Item.self)` for the key `\(key)` was successfully saved.")
            return item
        }

        if status == errSecDuplicateItem {
            return update(item, key: key)
        }

        let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String) ?? ""
        logger.fault("🔑🔒: Failed to save the keychain item `\(Item.self)` for the key `\(key)`. \(errorMessage)")
        return nil
    }

    public func loadItem<Item: Codable>(key: String) -> Item? {
        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrLabel: key,
            kSecReturnData: true,
        ] as CFDictionary

        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String) ?? ""
            logger.fault("🔑🔒: Failed to load the keychain item `\(Item.self)` for the key `\(key)`. \(errorMessage)")
            return nil
        }

        guard let data: Data = result as? Data else {
            logger.fault("🔑🔒: Failed to parse the found result as `Data` for the key `\(key)`.")
            return nil
        }

        guard let item: Item = try? jsonDecoder.decode(Item.self, from: data) else {
            logger.fault("🔑🔒: Failed to decode the item's data as `\(Item.self)` for the key `\(key)`.")
            return nil
        }

        logger.info("🔑🔒: The keychain item `\(Item.self)` for the key `\(key)` was successfully loaded.")
        return item
    }

    public func deleteItem(key: String) {
        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrLabel: key,
        ] as CFDictionary

        let status: OSStatus = SecItemDelete(query)

        guard status == errSecSuccess else {
            let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String) ?? ""
            logger.fault("🔑🔒: Failed to delete the keychain item for the key `\(key)`. \(errorMessage)")
            return
        }

        logger.info("🔑🔒: The keychain item for the key `\(key)` was successfully deleted.")
    }

    private func update<Item: Codable>(_ item: Item, key: String) -> Item? {
        guard let data: Data = try? jsonEncoder.encode(item) else {
            logger.fault("🔑🔒: Failed to encode the item `\(Item.self)` for the key `\(key)`.")
            return nil
        }

        let query: CFDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecAttrLabel: key,
        ] as CFDictionary

        let attributesToUpdate: CFDictionary = [kSecValueData: data] as CFDictionary
        let status: OSStatus = SecItemUpdate(query, attributesToUpdate)

        guard status == errSecSuccess else {
            let errorMessage: String = (SecCopyErrorMessageString(status, nil) as? String) ?? ""
            logger.fault("🔑🔒: Failed to update the keychain item `\(Item.self)` for the key `\(key)`. \(errorMessage)")
            return nil
        }

        logger.info("🔑🔒: The keychain item `\(Item.self)` for the key `\(key)` was successfully updated.")
        return item
    }
}

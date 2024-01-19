//
//  KeychainedTests.swift
//  FinFeatherTests
//
//  Created by Dmytro Yantsybaiev on 29.10.2023.
//

@testable import FinFeather

import XCTest
import FFKeychain

final class KeychainedTests: XCTestCase {

    @Keychained(\.test) private var keychainedItem: String?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        FFKeychain.shared.deleteItem(key: KeychainedValues.shared.test)
    }

    func test_initial_item() {
        XCTAssertNil(keychainedItem)
    }

    func test_set_item() {
        let itemToSet: String = "itemToSet"
        keychainedItem = itemToSet
        XCTAssertEqual(itemToSet, FFKeychain.shared.loadItem(key: KeychainedValues.shared.test) as String?)
    }

    func test_get_tem() {
        keychainedItem = "itemToGet"
        let keychainedItem: String? = FFKeychain.shared.loadItem(key: KeychainedValues.shared.test)
        XCTAssertNotNil(keychainedItem)
        XCTAssertEqual(keychainedItem, keychainedItem)
    }

    func test_update_item() {
        let itemToSet: String = "itemToSet"
        let itemToUpdate: String = "itemToUpdate"
        keychainedItem = itemToSet
        keychainedItem = itemToUpdate
        XCTAssertEqual(itemToUpdate, FFKeychain.shared.loadItem(key: KeychainedValues.shared.test) as String?)
    }

    func test_delete_item() {
        keychainedItem = "itemToSet"
        XCTAssertNotNil(FFKeychain.shared.loadItem(key: KeychainedValues.shared.test) as String?)
        keychainedItem = nil
        XCTAssertNil(FFKeychain.shared.loadItem(key: KeychainedValues.shared.test) as String?)
    }
}

private extension KeychainedValues {

    var test: String { "test" }
}


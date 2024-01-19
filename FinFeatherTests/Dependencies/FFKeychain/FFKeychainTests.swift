//
//  FFKeychainTests.swift
//  FinFeatherTests
//
//  Created by Dmytro Yantsybaiev on 29.10.2023.
//

@testable import FFKeychain

import XCTest

final class FFKeychainTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        FFKeychain.shared.deleteItem(key: "Test")
    }

    func test_save_item() {
        let itemToSave: String = "itemToSave"
        let savedItem = FFKeychain.shared.save(itemToSave, key: "Test")
        XCTAssertEqual(itemToSave, savedItem)
    }

    func test_update_tem() {
        let itemToSave: String = "itemToSave"
        let itemToUpdate: String = "itemToUpdate"
        FFKeychain.shared.save(itemToSave, key: "Test")
        let updatedItem = FFKeychain.shared.save(itemToUpdate, key: "Test")
        XCTAssertEqual(itemToUpdate, updatedItem)
    }

    func test_load_item() {
        let itemToSave: String = "itemToSave"
        FFKeychain.shared.save(itemToSave, key: "Test")
        XCTAssertEqual(itemToSave, FFKeychain.shared.loadItem(key: "Test") as String?)
    }

    func test_delete_item() {
        let itemToSave: String = "itemToSave"
        FFKeychain.shared.save(itemToSave, key: "Test")
        XCTAssertNotNil(FFKeychain.shared.loadItem(key: "Test") as String?)
        FFKeychain.shared.deleteItem(key: "Test")
        XCTAssertNil(FFKeychain.shared.loadItem(key: "Test") as String?)
    }
}

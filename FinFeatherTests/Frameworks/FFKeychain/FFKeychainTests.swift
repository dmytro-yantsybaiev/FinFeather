//
//  FFKeychainTests.swift
//  FinFeatherTests
//
//  Created by Dmytro Yantsybaiev on 29.10.2023.
//

import XCTest
@testable import FFKeychain

final class FFKeychainTests: XCTestCase {

    override func tearDown() {
        super.tearDown()
        FFKeychain.shared.deleteItem(key: .test)
    }

    func testSaveItem() {
        let itemToSave: String = "itemToSave"
        let savedItem = FFKeychain.shared.save(itemToSave, key: .test)
        XCTAssertEqual(itemToSave, savedItem)
    }

    func testUpdateItem() {
        let itemToSave: String = "itemToSave"
        let itemToUpdate: String = "itemToUpdate"
        FFKeychain.shared.save(itemToSave, key: .test)
        let updatedItem = FFKeychain.shared.save(itemToUpdate, key: .test)
        XCTAssertEqual(itemToUpdate, updatedItem)
    }

    func testLoadItem() {
        let itemToSave: String = "itemToSave"
        FFKeychain.shared.save(itemToSave, key: .test)
        XCTAssertEqual(itemToSave, FFKeychain.shared.loadItem(key: .test) as String?)
    }

    func testDeleteItem() {
        let itemToSave: String = "itemToSave"
        FFKeychain.shared.save(itemToSave, key: .test)
        XCTAssertNotNil(FFKeychain.shared.loadItem(key: .test) as String?)
        FFKeychain.shared.deleteItem(key: .test)
        XCTAssertNil(FFKeychain.shared.loadItem(key: .test) as String?)
    }
}

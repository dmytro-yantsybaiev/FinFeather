//
//  KeychainedTests.swift
//  FinFeatherTests
//
//  Created by Dmytro Yantsybaiev on 29.10.2023.
//

import XCTest
import FFKeychain
@testable import FinFeather

final class KeychainedTests: XCTestCase {

    @Keychained(.test) private var testItem: String?

    override func tearDown() {
        super.tearDown()
        FFKeychain.shared.deleteItem(key: .test)
    }

    func testInitialItem() {
        XCTAssertNil(testItem)
    }

    func testSetItem() {
        let itemToSet: String = "itemToSet"
        testItem = itemToSet
        XCTAssertEqual(itemToSet, FFKeychain.shared.loadItem(key: .test) as String?)
    }

    func testGetItem() {
        testItem = "itemToGet"
        let keychainedItem: String? = FFKeychain.shared.loadItem(key: .test)
        XCTAssertNotNil(keychainedItem)
        XCTAssertEqual(testItem, keychainedItem)
    }

    func testUpdateItem() {
        let itemToSet: String = "itemToSet"
        let itemToUpdate: String = "itemToUpdate"
        testItem = itemToSet
        testItem = itemToUpdate
        XCTAssertEqual(itemToUpdate, FFKeychain.shared.loadItem(key: .test) as String?)
    }

    func testDeleteItem() {
        testItem = "itemToSet"
        XCTAssertNotNil(FFKeychain.shared.loadItem(key: .test) as String?)
        testItem = nil
        XCTAssertNil(FFKeychain.shared.loadItem(key: .test) as String?)
    }
}

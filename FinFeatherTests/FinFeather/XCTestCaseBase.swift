//
//  XCTestCaseBase.swift
//  FinFeatherTests
//
//  Created by Dmytro Yantsybaiev on 20.01.2024.
//

import XCTest
import SwiftData
import Resolver

class XCTestCaseBase: XCTestCase {

    override func setUp() {
        super.setUp()

        // this is done in order to trigger the registerAllServices() func of Resolver the Test environment
        _ = Resolver.resolve(ModelContainer.self)
    }
}

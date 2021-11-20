//
//  ValkyrieTests.swift
//  ValkyrieTests
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import XCTest

private final class Valkyrie {

    // MARK: - Properties

    let name = "Valkyrie"
}

class ValkyrieTests: XCTestCase {

    func test_name_returnsName() {
        let sut = Valkyrie()
        XCTAssertEqual(sut.name, "Valkyrie")
    }
}

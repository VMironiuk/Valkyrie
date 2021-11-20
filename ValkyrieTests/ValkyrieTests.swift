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
    let greeting = "Hei Verden!"
    let winMessage = "Slik blir det med alle!"
    let loseMessage = "Faen!🤯"
}

class ValkyrieTests: XCTestCase {

    func test_name_returnsName() {
        let sut = Valkyrie()
        XCTAssertEqual(sut.name, "Valkyrie")
    }

    func test_greeting_returnsGreetingMessage() {
        let sut = Valkyrie()
        XCTAssertEqual(sut.greeting, "Hei Verden!")
    }

    func test_winMessage_returnsWinMessage() {
        let sut = Valkyrie()
        XCTAssertEqual(sut.winMessage, "Slik blir det med alle!")
    }

    func test_loseMessage_returnsLoseMessage() {
        let sut = Valkyrie()
        XCTAssertEqual(sut.loseMessage, "Faen!🤯")
    }
}

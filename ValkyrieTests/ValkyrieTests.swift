//
//  ValkyrieTests.swift
//  ValkyrieTests
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import XCTest

private final class Valkyrie {

    // MARK: - Public Properties

    let name = "Valkyrie"
    let greeting = "Hei Verden!"
    let winMessage = "Slik blir det med alle!"
    let loseMessage = "Faen!🤯"

    // MARK: - Private Properties

    let tile: CGRect

    // MARK: - Initializers

    init(tile: CGRect) {
        self.tile = tile
    }

    // MARK: - Public Methods

    func shoot() -> CGPoint {
        .zero
    }
}

class ValkyrieTests: XCTestCase {

    // MARK: - Tests for basic properties

    func test_name_returnsName() {
        let sut = makeSUT()
        XCTAssertEqual(sut.name, "Valkyrie")
    }

    func test_greeting_returnsGreetingMessage() {
        let sut = makeSUT()
        XCTAssertEqual(sut.greeting, "Hei Verden!")
    }

    func test_winMessage_returnsWinMessage() {
        let sut = makeSUT()
        XCTAssertEqual(sut.winMessage, "Slik blir det med alle!")
    }

    func test_loseMessage_returnsLoseMessage() {
        let sut = makeSUT()
        XCTAssertEqual(sut.loseMessage, "Faen!🤯")
    }

    // MARK: - Tests for simple shooting

    func test_shoot_beginsToShootFromTopLeftCornerOfTile() {
        (0...10).forEach { side in
            let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: side, height: side))
            let expectedPointForFirstShoot = CGPoint(x: 0, y: 0)
            let actualPointForFirstShoot = sut.shoot()
            XCTAssertEqual(expectedPointForFirstShoot, actualPointForFirstShoot)
        }
    }

    // MARK: - Helpers

    private func makeSUT(tile: CGRect = .zero) -> Valkyrie {
        Valkyrie(tile: tile)
    }
}

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
        if tile == CGRect.zero {
            return CGPoint.zero
        }

        if Int(tile.width) % 2 == 0 {
            return CGPoint.zero
        } else {
            return CGPoint(x: Int(tile.width) / 2, y: Int(tile.height) / 2)
        }
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

    func test_shoot_returnsSomePointForUnspecifedBoard() {
        let sut = makeSUT()
        let expectedShootPoint = CGPoint(x: 0, y: 0)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    func test_shoot_returnsZeroPointFor1x1Tile() {
        let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: 1, height: 1))
        let expectedShootPoint = CGPoint(x: 0, y: 0)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    func test_shoot_returnsZeroPointFor2x2Tile() {
        let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: 2, height: 2))
        let expectedShootPoint = CGPoint(x: 0, y: 0)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    func test_shoot_returnsCenterPointFor3x3Tile() {
        let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: 3, height: 3))
        let expectedShootPoint = CGPoint(x: 1, y: 1)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    func test_shoot_returnsCenterPointFor4x4Tile() {
        let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: 4, height: 4))
        let expectedShootPoint = CGPoint(x: 0, y: 0)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    func test_shoot_returnsCenterPointFor5x5Tile() {
        let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: 5, height: 5))
        let expectedShootPoint = CGPoint(x: 2, y: 2)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    func test_shoot_returnsCenterPointFor6x6Tile() {
        let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: 6, height: 6))
        let expectedShootPoint = CGPoint(x: 0, y: 0)
        let actualShootPoint = sut.shoot()
        XCTAssertEqual(expectedShootPoint, actualShootPoint)
    }

    // MARK: - Helpers

    private func makeSUT(tile: CGRect = .zero) -> Valkyrie {
        Valkyrie(tile: tile)
    }
}

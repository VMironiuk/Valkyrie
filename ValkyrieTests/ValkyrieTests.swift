//
//  ValkyrieTests.swift
//  ValkyrieTests
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import XCTest
import Valkyrie

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

    func test_shoot_beginsToShootTopLeftCornersOfTilesFor20x20BoardAnd3x5Ships() {
        let sut = makeSUT(board: CGRect(x: 0, y: 0, width: 20, height: 20), ship: CGSize(width: 3, height: 5))
        let expectedShootPoints = [
            CGPoint(x: 0, y: 0), CGPoint(x: 5, y: 0), CGPoint(x: 10, y: 0), CGPoint(x: 15, y: 0),
            CGPoint(x: 0, y: 5), CGPoint(x: 5, y: 5), CGPoint(x: 10, y: 5), CGPoint(x: 15, y: 5),
            CGPoint(x: 0, y: 10), CGPoint(x: 5, y: 10), CGPoint(x: 10, y: 10), CGPoint(x: 15, y: 10),
            CGPoint(x: 0, y: 15), CGPoint(x: 5, y: 15), CGPoint(x: 10, y: 15), CGPoint(x: 15, y: 15)
        ]
        let actualShootPoints = [
            sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(),
            sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(),
            sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(),
            sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot()
        ]
        XCTAssertEqual(expectedShootPoints, actualShootPoints)
    }

    func test_shoot_shootsByDiagonalOfTiles() {
        let sut = makeSUT(board: CGRect(x: 0, y: 0, width: 8, height: 8), ship: CGSize(width: 1, height: 4))
        let expectedShootPoints = [
            CGPoint(x: 0, y: 0), CGPoint(x: 4, y: 0), CGPoint(x: 0, y: 4), CGPoint(x: 4, y: 4),
            CGPoint(x: 1, y: 1), CGPoint(x: 5, y: 1), CGPoint(x: 1, y: 5), CGPoint(x: 5, y: 5),
            CGPoint(x: 2, y: 2), CGPoint(x: 6, y: 2), CGPoint(x: 2, y: 6), CGPoint(x: 6, y: 6),
            CGPoint(x: 3, y: 3), CGPoint(x: 7, y: 3), CGPoint(x: 3, y: 7), CGPoint(x: 7, y: 7)
        ]
        let actualShootPoints = [
            sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(),
            sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot(), sut.shoot()
        ]
        XCTAssertEqual(expectedShootPoints, actualShootPoints)
    }

    func test_shoot_shotsOfBoardCompletely() {
        let sut = makeSUT(board: CGRect(x: 0, y: 0, width: 8, height: 8), ship: CGSize(width: 1, height: 4))
        var expectedShootPoints = [CGPoint]()
        for row in 0..<8 {
            for column in 0..<8 {
                expectedShootPoints.append(CGPoint(x: row, y: column))
            }
        }
        let actualShootPoints = (0..<(8 * 8)).reduce([]) { partialResult, _ in
            partialResult + [sut.shoot()]
        }
        XCTAssertEqual(expectedShootPoints.count, actualShootPoints.count)
        expectedShootPoints.forEach {
            XCTAssertTrue(actualShootPoints.contains($0))
        }
    }

    // MARK: - Helpers

    private func makeSUT(board: CGRect = .zero, ship: CGSize = .zero) -> Valkyrie {
        Valkyrie(board: board, ship: ship)
    }
}

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

    func test_shoot_beginsToShootFromTopLeftCornerOfTile() {
        (0...20).forEach { side in
            let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: side, height: side))
            let expectedPointForFirstShoot = CGPoint(x: 0, y: 0)
            let actualPointForFirstShoot = sut.shoot()
            XCTAssertEqual(expectedPointForFirstShoot, actualPointForFirstShoot)
        }
    }

    func test_shoot_shootsByDiagonal() {
        (0...20).forEach { side in
            let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: side, height: side))
            let expectedShootPoints = diagonalPoints(for: side)
            let actualShootPoints = actualDiagonalPoints(for: side, from: sut)
            XCTAssertEqual(expectedShootPoints, actualShootPoints)
        }
    }

    func test_shoot_shootsTileCompletely() {
        (0...20).forEach { side in
            let sut = makeSUT(tile: CGRect(x: 0, y: 0, width: side, height: side))
            let expectedShootPoints = completedShootPoints(for: side)
            let actualShootPoints = actualCompletedShootPoints(for: side, from: sut)
            XCTAssertEqual(expectedShootPoints.count, actualShootPoints.count)
            expectedShootPoints.forEach {
                XCTAssertTrue(actualShootPoints.contains($0))
            }
        }
    }

    // MARK: - Helpers

    private func makeSUT(tile: CGRect = .zero) -> Valkyrie {
        Valkyrie(tile: tile)
    }

    private func diagonalPoints(for count: Int) -> [CGPoint] {
        (0..<count).reduce([]) { partialResult, side in
            partialResult + [CGPoint(x: side, y: side)]
        }
    }

    private func actualDiagonalPoints(for count: Int, from sut: Valkyrie) -> [CGPoint] {
        (0..<count).reduce([]) { partialResult, _ in
            partialResult + [sut.shoot()]
        }
    }

    private func completedShootPoints(for count: Int) -> [CGPoint] {
        var result = [CGPoint]()
        for row in 0..<count {
            for column in 0..<count {
                result.append(CGPoint(x: row, y: column))
            }
        }

        return result
    }

    private func actualCompletedShootPoints(for count: Int, from sut: Valkyrie) -> [CGPoint] {
        (0..<(count * count)).reduce([]) { partialResult, _ in
            partialResult + [sut.shoot()]
        }
    }
}

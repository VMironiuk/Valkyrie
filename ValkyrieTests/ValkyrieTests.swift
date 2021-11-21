//
//  ValkyrieTests.swift
//  ValkyrieTests
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import XCTest
import Valkyrie

class ValkyrieTests: XCTestCase {

    // MARK: - Types

    typealias TestInputType = [(board: CGRect, ship: CGSize)]

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

    func test_shoots_shootsTheBoardCompletely() {
        makeTestInputs().forEach { testInput in
            let sut = makeSUT(board: testInput.board, ship: testInput.ship)
            let expectedShootPoints = expectedCompleteShootPoints(for: Int(testInput.board.width))
            let actualShootPoints = completedShootPoints(from: sut)
            XCTAssertEqual(expectedShootPoints.count, actualShootPoints.count)
            expectedShootPoints.forEach {
                XCTAssertTrue(actualShootPoints.contains($0), "Valkyrie didn't shoot to the point \($0)")
            }
        }
    }

    // MARK: - Helpers

    private func makeSUT(board: CGRect = .zero, ship: CGSize = .zero) -> Valkyrie {
        Valkyrie(board: board, ship: ship)
    }

    private func expectedCompleteShootPoints(for boardSide: Int) -> [CGPoint] {
        var points = [CGPoint]()
        for row in 0..<boardSide {
            for column in 0..<boardSide {
                points.append(CGPoint(x: row, y: column))
            }
        }
        return points
    }

    private func completedShootPoints(from sut: Valkyrie) -> [CGPoint] {
        var points = [CGPoint]()
        while !sut.isEmpty {
            points.append(sut.shoot())
        }
        return points
    }

    private func makeTestInputs() -> TestInputType {
        [
            (board: CGRect(x: .zero, y: .zero, width: 20, height: 20), ship: CGSize(width: 3, height: 5)),
            (board: CGRect(x: .zero, y: .zero, width: 20, height: 20), ship: CGSize(width: 2, height: 3)),
            (board: CGRect(x: .zero, y: .zero, width: 30, height: 30), ship: CGSize(width: 10, height: 10)),
            (board: CGRect(x: .zero, y: .zero, width: 30, height: 30), ship: CGSize(width: 1, height: 8)),
            (board: CGRect(x: .zero, y: .zero, width: 40, height: 40), ship: CGSize(width: 6, height: 8))
        ]
    }
}

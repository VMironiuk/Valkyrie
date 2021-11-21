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

    func test_shoot_shootsTheBoardCompletely() {
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

    func test_finisherReturnsNearPointsArountHitPoint() {
        let hitPoint = CGPoint(x: 8, y: 8)
        let finisher = Finisher()
        finisher.update(with: hitPoint)
        let expectedPoints = [
            CGPoint(x: 7, y: 7), CGPoint(x: 8, y: 7), CGPoint(x: 9, y: 7),
            CGPoint(x: 7, y: 8), CGPoint(x: 9, y: 8),
            CGPoint(x: 7, y: 9), CGPoint(x: 8, y: 9), CGPoint(x: 9, y: 9)
        ]
        let actualPoints = [
            finisher.shoot(), finisher.shoot(), finisher.shoot(), finisher.shoot(),
            finisher.shoot(), finisher.shoot(), finisher.shoot(), finisher.shoot()
        ]
        XCTAssertEqual(expectedPoints.count, actualPoints.count)
        expectedPoints.forEach {
            XCTAssertTrue(actualPoints.contains($0))
        }
    }

    func test_finisherReturnsNearPointsArountOtherHitPoint() {
        let hitPoint = CGPoint(x: 8, y: 8)
        let otherHitPoint = CGPoint(x: 9, y: 9)
        let finisher = Finisher()
        finisher.update(with: hitPoint)
        finisher.update(with: otherHitPoint)
        let expectedPoints = [
            CGPoint(x: 7, y: 7), CGPoint(x: 8, y: 7), CGPoint(x: 9, y: 7), CGPoint(x: 7, y: 8), CGPoint(x: 10, y: 8),
            CGPoint(x: 7, y: 9), CGPoint(x: 10, y: 9), CGPoint(x: 8, y: 10), CGPoint(x: 9, y: 10), CGPoint(x: 10, y: 10)
        ]
        let actualPoints = [
            finisher.shoot(), finisher.shoot(), finisher.shoot(), finisher.shoot(), finisher.shoot(),
            finisher.shoot(), finisher.shoot(), finisher.shoot(), finisher.shoot(), finisher.shoot()
        ]
        XCTAssertEqual(expectedPoints.count, actualPoints.count)
        expectedPoints.forEach {
            XCTAssertTrue(actualPoints.contains($0))
        }
    }

    // MARK: - Helpers

    private final class Finisher {

        // MARK: - Public Properties

        var isEmpty: Bool {
            queue.isEmpty
        }

        // MARK: - Private Properties

        private var queue = [CGPoint]()
        private var previousHitPoint = CGPoint(x: -1, y: -1)

        // MARK: - Public Methods

        func update(with hitPoint: CGPoint) {
            let newQueue = [
                CGPoint(x: hitPoint.x - 1, y: hitPoint.y - 1), CGPoint(x: hitPoint.x, y: hitPoint.y - 1),
                CGPoint(x: hitPoint.x + 1, y: hitPoint.y - 1), CGPoint(x: hitPoint.x - 1, y: hitPoint.y),
                CGPoint(x: hitPoint.x + 1, y: hitPoint.y), CGPoint(x: hitPoint.x - 1, y: hitPoint.y + 1),
                CGPoint(x: hitPoint.x, y: hitPoint.y + 1), CGPoint(x: hitPoint.x + 1, y: hitPoint.y + 1)
            ]
            let oldSet = Set(queue)
            let newSet = Set(newQueue)
            queue = Array(oldSet.symmetricDifference(newSet))
            queue.removeAll(where: { $0 == hitPoint })
            queue.removeAll(where: { $0 == previousHitPoint })
            previousHitPoint = hitPoint
        }

        func shoot() -> CGPoint {
            if queue.isEmpty {
                return CGPoint(x: -1, y: -1)
            }

            return queue.removeFirst()
        }
    }

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

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

//
//  FinisherTests.swift
//  ValkyrieTests
//
//  Created by Vladimir Mironiuk on 21.11.2021.
//

import XCTest
import Valkyrie

class FinisherTests: XCTestCase {

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
}

//
//  Finisher.swift
//  Valkyrie
//
//  Created by Vladimir Mironiuk on 21.11.2021.
//

import Foundation

public final class Finisher {

    // MARK: - Public Properties

    var isEmpty: Bool {
        queue.isEmpty
    }

    // MARK: - Private Properties

    private var queue = [CGPoint]()
    private var previousHitPoint = CGPoint(x: -1, y: -1)

    // MARK: - Initializers

    public init() {}

    // MARK: - Public Methods

    public func update(with hitPoint: CGPoint) {
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

    public func shoot() -> CGPoint {
        if queue.isEmpty {
            return CGPoint(x: -1, y: -1)
        }

        return queue.removeFirst()
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

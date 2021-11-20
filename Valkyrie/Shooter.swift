//
//  Shooter.swift
//  Valkyrie
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import Foundation

final class Shooter {

    // MARK: - Private Properties

    private let tile: CGRect
    private var queue = [CGPoint]()

    // MARK: - Initializers

    init(tile: CGRect) {
        self.tile = tile
        setupQueue()
    }

    // MARK: - Public Methods

    func shoot() -> CGPoint {
        if !queue.isEmpty {
            return queue.removeFirst()
        }

        return .zero
    }

    // MARK: - Private Methods

    func setupQueue() {
        for index in 0..<Int(tile.width) {
            queue.append(CGPoint(x: Int(tile.origin.x) + index, y: Int(tile.origin.y) + index))
        }

        for row in 0..<Int(tile.width) {
            for column in 0..<Int(tile.height) {
                let point = CGPoint(x: Int(tile.origin.x) + row, y: Int(tile.origin.y) + column)
                if !queue.contains(point) {
                    queue.append(point)
                }
            }
        }
    }
}

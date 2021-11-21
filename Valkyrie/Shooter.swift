//
//  Shooter.swift
//  Valkyrie
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import Foundation

final class Shooter {

    // MARK: - Public Properties

    var isEmpty: Bool {
        queue.isEmpty
    }

    // MARK: - Private Properties

    private var queue = [CGPoint]()

    // MARK: - Initializers

    init(tile: CGRect, boardSize: CGSize) {
        setupQueue(with: boardSize, tile: tile)
    }

    // MARK: - Public Methods

    func shoot() -> CGPoint {
        if !queue.isEmpty {
            return queue.removeFirst()
        }

        return CGPoint(x: -1, y: -1)
    }

    // MARK: - Private Methods

    func setupQueue(with boardSize: CGSize, tile: CGRect) {
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

        queue = queue.filter {
            $0.x < boardSize.width && $0.y < boardSize.height
        }
    }
}

//
//  ShootingController.swift
//  Valkyrie
//
//  Created by Vladimir Mironiuk on 21.11.2021.
//

import Foundation

final class ShootingController {

    // MARK: - Public Properties

    var isEmpty: Bool {
        shooters.isEmpty
    }

    // MARK: - Private Properties

    private var shooters = [Shooter]()

    // MARK: - Initializers

    public init(board: CGRect, ship: CGSize) {
        let maxSide = Int(max(ship.width, ship.height))

        var originX = 0
        var originY = 0
        while originY < Int(board.height) {
            while originX < Int(board.width) {
                shooters.append(Shooter(
                    tile: CGRect(x: originX, y: originY, width: maxSide, height: maxSide),
                    boardSize: CGSize(width: board.width, height: board.height)))
                originX += maxSide
            }
            originY += maxSide
            originX = 0
        }
    }

    // MARK: - Public Methods

    func shoot() -> CGPoint {
        if shooters.isEmpty {
            return CGPoint(x: -1, y: -1)
        }

        let shootPoint = shooters[.zero].shoot()
        shooters.shuffle()
        shooters = shooters.filter {
            !$0.isEmpty
        }

        return shootPoint
    }
}

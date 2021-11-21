//
//  Valkyrie.swift
//  Valkyrie
//
//  Created by Vladimir Mironiuk on 20.11.2021.
//

import Foundation

public final class Valkyrie {

    // MARK: - Public Properties

    public let name = "Valkyrie"
    public let greeting = "Hei Verden!"
    public let winMessage = "Slik blir det med alle!"
    public let loseMessage = "Faen!🤯"
    public var isEmpty: Bool {
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

    public func shoot() -> CGPoint {
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

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

    // MARK: - Private Properties

    private let shooter: Shooter

    // MARK: - Initializers

    public init(tile: CGRect) {
        shooter = Shooter(tile: tile)
    }

    // MARK: - Public Methods

    public func shoot() -> CGPoint {
        shooter.shoot()
    }
}

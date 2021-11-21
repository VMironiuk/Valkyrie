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
        shootingController.isEmpty
    }

    // MARK: - Private Properties

    private let shootingController: ShootingController

    // MARK: - Initializers

    public init(board: CGRect, ship: CGSize) {
        shootingController = ShootingController(board: board, ship: ship)
    }

    // MARK: - Public Methods

    public func shoot() -> CGPoint {
        shootingController.shoot()
    }
}

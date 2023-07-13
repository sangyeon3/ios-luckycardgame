//
//  LuckyCardManagerProtocol.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/12.
//

import Foundation

protocol LuckyCardManagerProtocol {
    func splitCard(gameType: LuckyGame.GameType) -> [[LuckyCard]]
}

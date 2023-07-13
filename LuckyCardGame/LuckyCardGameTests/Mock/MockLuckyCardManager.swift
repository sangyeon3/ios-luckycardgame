//
//  MockLuckyCardManager.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/12.
//

import Foundation

final class MockLuckyCardManager: LuckyCardManagerProtocol {
    
    private let splitedCards: [[LuckyCard]]
    
    init(splitedCards: [[LuckyCard]]) {
        self.splitedCards = splitedCards
    }
    
    func splitCard(gameType: LuckyGame.GameType) -> [[LuckyCard]] {
        return splitedCards
    }
}

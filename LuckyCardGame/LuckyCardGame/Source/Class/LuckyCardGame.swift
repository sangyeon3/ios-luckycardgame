//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/05.
//

import Foundation

final class LuckyCardGame {
    
    static let defaultPlayerCount = 3
    static let maxPlayerCount = 5
    
    enum GameType: Int, CaseIterable {
        case threePlayer
        case fourPlayer
        case fivePlayer
        
        var playerCount: Int {
            return rawValue + LuckyCardGame.defaultPlayerCount
        }
        
        var typeName: String {
            return "\(playerCount)명"
        }
        
        var cardShapesToFilter: Set<LuckyCard.Shape> {
            return []
        }
        
        var cardNumbersToFilter: Set<LuckyCard.Number> {
            switch self {
            case .threePlayer:
                return [.twelve]
            default:
                return []
            }
        }
        
        var cardCountPerPlayer: Int {
            switch self {
            case .threePlayer:
                return 8
            case .fourPlayer:
                return 7
            case .fivePlayer:
                return 6
            }
        }
        
        var remainCardCount: Int {
            switch self {
            case .threePlayer:
                return 9
            case .fourPlayer:
                return 8
            case .fivePlayer:
                return 6
            }
        }
    }
    
    private let cardManager: LuckyCardManager
    var players: [Player]
    var remainCards: [LuckyCard] = []
    
    init(cardManager: LuckyCardManager, players: [Player]) {
        self.cardManager = cardManager
        self.players = players
    }
    
    /// 플레이어들에게 카드를 나눠주고 그 결과를 반환
    func splitCard(gameType: GameType) -> [[LuckyCard]] {
        let splitedCard = cardManager.splitCard(gameType: gameType)
        for i in 0..<gameType.playerCount {
            players[i].receiveCards(splitedCard[i])
        }
        remainCards = splitedCard[gameType.playerCount]
        return splitedCard
    }

}

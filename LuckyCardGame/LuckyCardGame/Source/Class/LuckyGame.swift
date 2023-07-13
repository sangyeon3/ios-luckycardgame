//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/05.
//

import Foundation

final class LuckyGame {
    
    static let defaultPlayerCount = 3
    static let maxPlayerCount = 5
    
    enum GameType: Int, CaseIterable {
        case threePlayer
        case fourPlayer
        case fivePlayer
        
        var playerCount: Int {
            return rawValue + LuckyGame.defaultPlayerCount
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
            return 11 - self.playerCount
        }
        
        var remainCardCount: Int {
            switch self {
            case .threePlayer:
                return 36 - (3 + cardCountPerPlayer * playerCount)
            default:
                return 36 - cardCountPerPlayer * playerCount
            }
        }
    }
    
    private let cardManager: LuckyCardManagerProtocol
    var players: [Player]
    var remainCards: [LuckyCard] = []
    var selectedCards: [SelectedCard] = []
    
    init(cardManager: LuckyCardManagerProtocol) {
        self.cardManager = cardManager
        self.players = [Player](repeating: Player(), count: LuckyGame.maxPlayerCount)
    }
    
    /// 플레이어들에게 카드를 나눠주고 그 결과를 반환
    func splitCard(gameType: GameType) -> [[LuckyCard]] {
        let splitedCard = cardManager.splitCard(gameType: gameType)
        
        for i in 0..<gameType.playerCount {
            players[i].receiveCards(splitedCard[i])
            sortPlayerCards(playerIndex: i)
        }
        remainCards = splitedCard[gameType.playerCount]
        return splitedCard
    }
    
    func sortPlayerCards(playerIndex: Int) {
        players[playerIndex].sortCards()
    }
    
    func sortRemainCards() {
        remainCards.sort()
    }
    
    /// 같은 숫자 카드 3개를 가진 플레이어가 존재하는지 여부를 반환
    func existsPlayerHaving3SameNumberCard() -> Bool {
        players.map { $0.has3sameNumberCard() }.contains(true)
    }
    
    /// 플레이어의 (cardIndex+1)번째 카드를 선택할 수 있는지 여부를 반환
    func isPossibleToSelectPlayerCard(playerIndex: Int, cardIndex: Int) -> Bool {
        let card = SelectedCard(
            type: .playerCard(playerIndex: playerIndex),
            index: cardIndex
            )
        return !selectedCards.contains(card)
    }
    
    func selectPlayerCard(playerIndex: Int, cardIndex: Int) {
        let selectedCard = SelectedCard(
            type: .playerCard(playerIndex: playerIndex),
            index: cardIndex
            )
        selectedCards.append(selectedCard)
    }
    
    /// 바닥 카드의 (index+1)번째 카드를 선택할 수 있는지 여부를 반환
    func isPossibleToSelectRemainCard(index: Int) -> Bool {
        let card = SelectedCard(type: .remainCard, index: index)
        return !selectedCards.contains(card)
    }

    func selectRemainCard(index: Int) {
        let selectedCard = SelectedCard(type: .remainCard, index: index)
        selectedCards.append(selectedCard)
    }
    
    /// 선택된 카드들의 숫자가 모두 같은지 여부를 반환
    func checkSelectedCardsAreSame() -> Bool {
        var cards = [LuckyCard]()
        selectedCards.forEach{ selectedCard in
            if case let .playerCard(playerIndex) = selectedCard.type {
                let card = players[playerIndex].cards[selectedCard.index]
                cards.append(card)
            } else {
                let card = remainCards[selectedCard.index]
                cards.append(card)
            }
        }
        return (cards[0].number == cards[1].number) && (cards[0].number == cards[2].number)
    }
}

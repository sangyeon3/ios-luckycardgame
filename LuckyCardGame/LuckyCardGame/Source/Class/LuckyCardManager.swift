//
//  LuckyCardManager.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/08.
//

import Foundation

/*
 class : 다른 카드 분배 룰을 가질 경우 해당 카드매니저를 상속하여 사용할 수 있도록 확장성을 고려
 */

class LuckyCardManager {
    
    init() { }
    
    /// 게임 타입에 따라 카드를 분배하여 반환
    func splitCard(gameType: LuckyCardGame.GameType) -> [[LuckyCard]] {
        let deck = createCardDeck(
            filteredShapes: gameType.cardShapesToFilter,
            filteredNumbers: gameType.cardNumbersToFilter
        )
        let cardCountPerPlayer = gameType.cardCountPerPlayer
        
        // 각 플레이어에게 나눠줄 카드 분배
        var splitedCard = [[LuckyCard]]()
        for playerNumber in 0..<gameType.playerCount {
            let range = cardCountPerPlayer*playerNumber..<cardCountPerPlayer * (playerNumber+1)
            
            var cards = Array(deck[range])
            
            // 내 카드는 앞면을 보여주도록 설정
            if playerNumber == 0 {
                for index in 0..<cards.count {
                    cards[index].reverse()
                }
            }
            
            splitedCard.append(cards)
        }
        
        // 나머지 카드 append
        let range = cardCountPerPlayer*gameType.playerCount..<deck.count
        splitedCard.append(Array(deck[range]))
            
        return splitedCard
    }
    
    /// 전체 카드 덱을 생성하고 섞은 후 배열로 반환
    /// filteredShape과 filteredNumber를 통해 특정 모양과 숫자의 카드를 제외하고 생성할 수 있음
    private func createCardDeck(
        filteredShapes: Set<LuckyCard.Shape> = [],
        filteredNumbers: Set<LuckyCard.Number> = []
    ) -> [LuckyCard] {
        let deck = LuckyCard.Shape.allCases.flatMap { shape in
            LuckyCard.Number.allCases.compactMap { number -> LuckyCard? in
                if filteredShapes.contains(shape) || filteredNumbers.contains(number) { return nil }
                return LuckyCard(shape: shape, number: number)
            }
        }
        return deck.shuffled()
    }
}

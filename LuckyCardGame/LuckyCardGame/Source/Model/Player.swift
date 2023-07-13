//
//  Player.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/08.
//

import Foundation

struct Player {
    private(set) var cards: [LuckyCard]
    
    init(cards: [LuckyCard] = []) {
        self.cards = cards
    }
    
    mutating func receiveCards(_ cards: [LuckyCard]) {
        self.cards = cards
    }
    
    mutating func sortCards() {
        cards.sort()
    }
    
    /// 플레이어가 같은 숫자 카드 3개를 갖고 있는지 여부를 반환
    func has3sameNumberCard() -> Bool {
        var result = false
        LuckyCard.Number.allCases.forEach { number in
            let sameCardCount = cards.filter { $0.number == number }.count
            result = result || sameCardCount == 3
        }
        return result
    }
}

//
//  Player.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/08.
//

import Foundation

struct Player {
    private var cards: [LuckyCard]
    
    init(cards: [LuckyCard] = []) {
        self.cards = cards
    }
    
    /// 파라미터로 전달받은 LuckyCard 배열을 플레이어의 카드로 저장
    mutating func receiveCards(_ cards: [LuckyCard]) {
        self.cards = cards
    }
}

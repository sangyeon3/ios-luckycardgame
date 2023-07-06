//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/05.
//

import Foundation

final class LuckyCardGame {
    
    private var cardDeck: [LuckyCard]
    
    init(cardDeck: [LuckyCard]) {
        self.cardDeck = cardDeck
    }
    
    /// 카드 덱을 섞어줌
    func shuffleDeck() {
        cardDeck.shuffle()
    }
    
    /// 럭키카드 배열(덱)을 콤마(,)로 구분하여 출력
    func printDeck() {
        var string = ""
        cardDeck.forEach { card in
            string += "\(card.getStringInfo()), "
        }
        string.removeLast(2)
        print(string)
    }
}

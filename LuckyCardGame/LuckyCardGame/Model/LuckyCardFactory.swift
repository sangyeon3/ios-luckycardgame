//
//  CardFactory.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/05.
//

import Foundation

final class LuckyCardFactory {
    
    private let maxCardNumber: Int
    
    init(maxCardNumber: Int = 12) {
        self.maxCardNumber = maxCardNumber
    }
    
    /// 매개변수로 전달받은 모양과 숫자의 카드 인스턴스를 생성하여 반환
    func createCard(shape: LuckyCardShape, number: Int) -> LuckyCard? {
        if (1...maxCardNumber) ~= number {
            let newCard = LuckyCard(shape: shape, number: number)
            return newCard
        }
        return nil
    }
    
    /// 랜덤한 모양과 숫자의 카드 인스턴스를 생성하여 반환
    func createRandomCard() -> LuckyCard? {
        guard let shape = LuckyCardShape.allCases.randomElement(),
              let number = Array(1...maxCardNumber).randomElement() else {
            return nil
        }
        
        let newCard = LuckyCard(shape: shape, number: number)
        return newCard
    }
    
    /// 전체 카드 덱을 생성하고 섞은 후 출력하고 배열로 반환
    func createCardDeck() -> [LuckyCard] {
        var deck = [LuckyCard]()
        LuckyCardShape.allCases.forEach { shape in
            let newCards = Array(1...maxCardNumber).compactMap { number in
                createCard(shape: shape, number: number)
            }
            deck.append(contentsOf: newCards)
        }
        
        deck.shuffle()
        printDeck(deck)
        
        return deck
    }
    
    /// 럭키카드 배열(덱)을 콤마(,)로 구분하여 출력
    private func printDeck(_ deck: [LuckyCard]) {
        var string = ""
        deck.forEach { card in
            string += card.getStringInfo() + ", "
        }
        string.removeLast(2)
        print(string)
    }
}

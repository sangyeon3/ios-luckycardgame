//
//  SelectedCard.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/12.
//

import Foundation

struct SelectedCard: Equatable {
        
    enum CardType {
        case playerCard(playerIndex: Int)
        case remainCard
    }
    
    let type: CardType
    var index: Int
    
    static func == (lhs: SelectedCard, rhs: SelectedCard) -> Bool {
        if lhs.index != rhs.index {
            return false
        }
        if case let .playerCard(lhsPlayerIndex) = lhs.type,
           case let .playerCard(rhsPlayerIndex) = rhs.type {
            return lhsPlayerIndex == rhsPlayerIndex
        }
        if case .remainCard = lhs.type,
           case .remainCard = rhs.type {
            return true
        }
        return false
    }
}

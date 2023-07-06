//
//  Card.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/05.
//

import Foundation

enum LuckyCardShape: CaseIterable, CustomStringConvertible {
    case dog
    case cat
    case cow
    
    var description: String {
        switch self {
        case .dog:
            return "🐶"
        case .cat:
            return "🐱"
        case .cow:
            return "🐮"
        }
    }
}

final class LuckyCard {
    
    // 초기화 시 raw string으로 입력받을 경우 실수가 있을 수 있고, 어떤 shape이 존재하는지 명확히 하기 위해 Enum을 선택했습니다
    private let shape: LuckyCardShape
    
    // enum으로 표현할 경우 숫자 범위를 제한할 수 있다는 장점이 있었지만, case 이름을 숫자로 나타내지 못한다는 단점이 있어서 빠른 이해를 위해 Int 타입을 이용했습니다
    private let number: Int
    
    /// 카드 숫자를 String 타입으로 표현
    /// 예를 들어, 숫자가 1이면 "01", 숫자가 12이면 "12"
    private var numberString: String {
        if number < 10 {
            return "0\(number)"
        }
        return "\(number)"
    }
    
    init(shape: LuckyCardShape, number: Int) {
        self.shape = shape
        self.number = number
    }
    
    /// 카드의 모양과 숫자를 반환
    func getInfo() -> (shape: LuckyCardShape, number: Int) {
        return (shape, number)
    }
    
    /// 카드의 모양과 숫자를 문자열 타입으로 반환
    func getStringInfo() -> String {
        return "\(shape.description)\(numberString)"
    }
    
}

//
//  Card.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/05.
//

import Foundation

/*
 struct 선택 이유 :
 플레이어가 카드를 참조하기 보다는 소유한다는 의미가 맞는 것 같다
 또한 카드매니저가 카드 갖고있다가 플레이어에게 분배해주는데, 클래스를 이용할 경우 참조 관계 관리 어렵겠다는 생각이 듦
 */

struct LuckyCard: CustomStringConvertible {
    
    enum Shape: CaseIterable, CustomStringConvertible {
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
    
    enum Number: Int, CaseIterable, CustomStringConvertible {
        case one = 1
        case two, three, four, five, six, seven, eight, nine, ten, eleven, twelve
        
        var description: String {
            if rawValue < 10 {
                return "0\(rawValue)"
            } else {
                return "\(rawValue)"
            }
        }
    }
    
    // 초기화 시 raw string으로 입력받을 경우 실수가 있을 수 있고, 어떤 shape이 존재하는지 명확히 하기 위해 Enum을 선택했습니다
    private let shape: Shape
    
    // 숫자 범위를 1~12로 제한하기 위해 enum을 선택했습니다.
    private let number: Number
    
    private var isUp: Bool
    
    init(shape: Shape, number: Number) {
        self.shape = shape
        self.number = number
        self.isUp = false
    }
    
    /// "🐶01" 형식으로 리턴
    var description: String {
        shape.description + number.description
    }
    
    /// 카드의 모양과 숫자, 앞면인지 아닌지를 반환
    func fetchCardInfo() -> (shape: Shape, number: Number, isUp: Bool) {
        return (shape, number, isUp)
    }
    
    /// 카드를 뒤집음
    mutating func reverse() {
        self.isUp = !isUp
    }
    
}

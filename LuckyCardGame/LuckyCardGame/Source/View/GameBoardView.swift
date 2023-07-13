//
//  GameBoardView.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/09.
//

import UIKit

final class GameBoardView: UIView {
    
    // MARK: - UI Properties
    
    enum Size {
        static let viewSpacing = 10.0
        static let playerCardBoardViewHeight = 100.0
    }
    
    private let playerCardBoardViewArray = "ABCDE".map{
        let view = PersonalCardBoardView(frame: .zero, name: String($0))
        view.backgroundColor = .systemGray5
        return view
    }
    
    private let remainCardBoardView: PersonalCardBoardView = {
        let view = PersonalCardBoardView(frame: .zero)
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubviews()
    }
    
    private func addSubviews() {
        for playerCardBoardView in playerCardBoardViewArray {
            addSubview(playerCardBoardView)
        }
        addSubview(remainCardBoardView)
    }
    
    func configureFrame() {
        configurePlayerCardBoardViewsFrame()
        configureRemainCardBoardViewFrame(numberOfPlayer: LuckyGame.maxPlayerCount)
    }
    
    /// 각 플레이어가 소지한 카드를 보여주는 PlayerCardBoardView 배열의 frame을 설정
    private func configurePlayerCardBoardViewsFrame() {
        var frame = CGRect(
            x: 0,
            y: 0,
            width: frame.width,
            height: Size.playerCardBoardViewHeight
        )
        
        for playerCardBoardView in playerCardBoardViewArray {
            playerCardBoardView.frame = frame
            frame.origin.y += Size.playerCardBoardViewHeight + Size.viewSpacing
        }
    }
    
    /// 플레이어 수에 따라 남은 카드를 보여주는 remainCardBoardView의 frame을 설정
    private func configureRemainCardBoardViewFrame(numberOfPlayer: Int) {
        let minPlayerBoardCount = 4
        let y = (Size.playerCardBoardViewHeight + Size.viewSpacing) * CGFloat(max(numberOfPlayer, minPlayerBoardCount))
        let height = frame.size.height - y
        
        let frame = CGRect(
            x: 0,
            y: y,
            width: frame.width,
            height: height
        )
        
        remainCardBoardView.frame = frame
    }
    
    /// 게임 타입과 분배된 카드를 기반으로 뷰를 업데이트
    func update(for gameType: LuckyGame.GameType, with splitedCard: [[LuckyCard]]) {
        updateVisibilityOfPlayerBoardView(gameType)
        configureRemainCardBoardViewFrame(numberOfPlayer: gameType.playerCount)
        updateCardView(splitedCard)
    }
    
    /// 게임 타입에 따라 PlayerCardBoardView들의 isHidden 속성 값을 업데이트
    private func updateVisibilityOfPlayerBoardView(_ gameType: LuckyGame.GameType) {
        for index in 0..<playerCardBoardViewArray.count {
            playerCardBoardViewArray[index].isHidden = index >= gameType.playerCount
        }
    }
    
    /// 나눠준 카드에 따라 PlayerCardBoardView와 remainCardBoardView를 업데이트
    private func updateCardView(_ splitedCard: [[LuckyCard]]) {
        for index in 0..<splitedCard.count-1 {
            playerCardBoardViewArray[index].update(with: splitedCard[index])
        }
        remainCardBoardView.update(with: splitedCard[splitedCard.count-1])
    }
}

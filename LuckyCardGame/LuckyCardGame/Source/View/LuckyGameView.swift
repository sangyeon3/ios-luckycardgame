//
//  LuckyGameView.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/11.
//

import UIKit

protocol LuckyGameViewDelegate: AnyObject {
    func segmentIndexDidChanged(segmentIndex: Int)
}

final class LuckyGameView: UIView {
    
    // MARK: - UI Properties
    
    enum Size {
        static let segmentedControlHeight = 44.0
        static let viewSpacing = 10.0
    }
    
    private let segmentedControl = UISegmentedControl(items: LuckyGame.GameType.allCases.map { $0.typeName })
    
    private let gameBoardView = GameBoardView(frame: .zero)
    
    // MARK: - Properties
    
    weak var delegate: LuckyGameViewDelegate?
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addTargetToSegmentedControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
        addTargetToSegmentedControl()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(segmentedControl)
        addSubview(gameBoardView)
    }
    
    func configureFrame() {
        segmentedControl.frame = .init(x: 0, y: 0, width: frame.width, height: Size.segmentedControlHeight)
        
        let gameBoardViewY = Size.segmentedControlHeight + Size.viewSpacing
        gameBoardView.frame = CGRect(
            x: 0,
            y: gameBoardViewY,
            width: frame.width,
            height: frame.height - gameBoardViewY
        )
        
        gameBoardView.configureFrame()
    }
    
    private func addTargetToSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(indexDidChanged(of:)), for: .valueChanged)
    }
    
    @objc func indexDidChanged(of segment: UISegmentedControl) {
        delegate?.segmentIndexDidChanged(segmentIndex: segment.selectedSegmentIndex)
    }
    
    /// segmentedControl의 index를 0으로 초기화
    func initSelectedSegmentIndex() {
        segmentedControl.selectedSegmentIndex = 0
        indexDidChanged(of: segmentedControl)
    }
    
    /// 게임 타입과 분배된 카드에 따라 GameBoardView를 업데이트
    func updateGameBoardView(for gameType: LuckyGame.GameType, with splitedCard: [[LuckyCard]]) {
        gameBoardView.update(for: gameType, with: splitedCard)
    }
}

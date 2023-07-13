//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/04.
//

import UIKit

final class CardBoardViewController: UIViewController {
    
    enum Size {
        static let inset = 15.0
    }
    
    private let luckyGameView = LuckyGameView(frame: .zero)
    
    private let luckyGame: LuckyGame
    
    init() {
        let manager = LuckyCardManager()
        luckyGame = LuckyGame(cardManager: manager)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let manager = LuckyCardManager()
        luckyGame = LuckyGame(cardManager: manager)
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLuckyGameView()
        configureUI()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        configureFrame()
        luckyGameView.initSelectedSegmentIndex()
    }
    
    private func setupLuckyGameView() {
        luckyGameView.delegate = self
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(luckyGameView)
    }
    
    private func configureFrame() {
        let width = view.frame.width - (view.safeAreaInsets.left + view.safeAreaInsets.right) - (Size.inset * 2)
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        
        luckyGameView.frame = CGRect(
            x: Size.inset,
            y: view.safeAreaInsets.top,
            width: width,
            height: height
        )
        
        luckyGameView.configureFrame()
    }
}

// MARK: - LuckyGameViewDelegate

extension CardBoardViewController: LuckyGameViewDelegate {
    
    func segmentIndexDidChanged(segmentIndex: Int) {
        if let gameType = LuckyGame.GameType(rawValue: segmentIndex) {
            splitCard(gameType: gameType)
        }
    }
    
    /// 게임 타입에 따라 각 플레이어에게 카드를 나눠주고 view를 업데이트
    private func splitCard(gameType: LuckyGame.GameType) {
        let splitedCard = luckyGame.splitCard(gameType: gameType)
        luckyGameView.updateGameBoardView(for: gameType, with: splitedCard)
    }
}

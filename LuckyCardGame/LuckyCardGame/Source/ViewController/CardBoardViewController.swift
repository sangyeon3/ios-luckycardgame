//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/04.
//

import UIKit

class CardBoardViewController: UIViewController {
    
    enum Size {
        static let segmentedControlHeight = 44.0
        static let subViewsX = 15.0
        static let spacing = 10.0
    }
    
    private let segmentedControl = UISegmentedControl(
        items: LuckyCardGame.GameType.allCases.map { $0.typeName }
    )
    
    private let cardBoardView = CardBoardView()
    
    private let luckyCardGame: LuckyCardGame
    
    
    init() {
        let manager = LuckyCardManager()
        let players = [Player](repeating: Player(), count: 5)
        luckyCardGame = LuckyCardGame(cardManager: manager, players: players)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let manager = LuckyCardManager()
        let players = [Player](repeating: Player(), count: 5)
        luckyCardGame = LuckyCardGame(cardManager: manager, players: players)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        configureUI()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        configureFrame()
        updateSegmentIndex()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(indexDidChanged(of:)), for: .valueChanged)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(segmentedControl)
        view.addSubview(cardBoardView)
    }
    
    private func configureFrame() {
        let subViewWidth = view.frame.width - (view.safeAreaInsets.left + view.safeAreaInsets.right) - (Size.subViewsX * 2)
        
        configureSegmentedControlFrame(width: subViewWidth)
        configureCardBoardViewFrame(width: subViewWidth)
    }
    
    private func updateSegmentIndex() {
        segmentedControl.selectedSegmentIndex = 0
        indexDidChanged(of: segmentedControl)
    }
    
    @objc func indexDidChanged(of segment: UISegmentedControl) {
        if let gameType = LuckyCardGame.GameType(rawValue: segment.selectedSegmentIndex) {
            splitCard(gameType: gameType)
        }
    }
    
    /// 게임 타입에 따라 각 플레이어에게 카드를 나눠주고 view를 업데이트
    private func splitCard(gameType: LuckyCardGame.GameType) {
        let splitedCard = luckyCardGame.splitCard(gameType: gameType)
        cardBoardView.update(for: gameType, with: splitedCard)
    }
    
    // MARK: - configure subview's frame
    
    private func configureSegmentedControlFrame(width: CGFloat) {
        let frame = CGRect(
            x: Size.subViewsX,
            y: view.safeAreaInsets.top,
            width: width,
            height: Size.segmentedControlHeight
        )
        segmentedControl.frame = frame
    }
    
    private func configureCardBoardViewFrame(width: CGFloat) {
        let y = segmentedControl.frame.origin.y + segmentedControl.frame.size.height + Size.spacing
        let frame = CGRect(
            x: Size.subViewsX,
            y: y,
            width: width,
            height: view.frame.size.height - view.safeAreaInsets.bottom - y
        )
        
        cardBoardView.frame = frame
        cardBoardView.configureFrame()
    }
}


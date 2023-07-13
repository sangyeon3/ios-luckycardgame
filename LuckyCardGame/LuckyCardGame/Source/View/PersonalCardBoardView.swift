//
//  PersonalCardBoardView.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/04.
//

import UIKit

final class PersonalCardBoardView: UIView {
    
    static let maxCardCount = 9
    
    enum Size {
        static let nameLabelX = 15.0
        static let nameLabelY = 20.0
        static let nameLabelSize = 60.0
        static let cardViewInset = 5.0
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(
            x: Size.nameLabelX,
            y: Size.nameLabelY,
            width: Size.nameLabelSize,
            height: Size.nameLabelSize)
        )
        
        guard let fontDescriptor = UIFont
            .systemFont(ofSize: 40)
            .fontDescriptor
            .withSymbolicTraits([.traitBold, .traitItalic]) else {
            return label
        }
        label.font = UIFont(descriptor: fontDescriptor, size: 40)
        label.textColor = .gray.withAlphaComponent(0.5)
        
        return label
    }()
    
    private let cardViewArray = (0..<maxCardCount).map { _ in LuckyCardView() }
    
    init(frame: CGRect, name: String) {
        super.init(frame: frame)
        
        nameLabel.text = name
        configureUI()
    }
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame, name: "")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    private func configureUI() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(nameLabel)
        for cardView in cardViewArray {
            addSubview(cardView)
        }
    }
    
    /// 전달받은 카드 배열을 이용하여 view를 업데이트
    func update(with cards: [LuckyCard]) {
        updateCardViews(cards)
        configureCardViewsFrame(cardCount: cards.count)
    }
    
    /// 카드 정보에 따라 cardViewArray의 LuckyCardView를 업데이트
    private func updateCardViews(_ cards: [LuckyCard]) {
        for index in 0..<cardViewArray.count {
            let cardView = cardViewArray[index]
            if index < cards.count {
                cardView.isHidden = false
                cardView.update(for: cards[index])
            } else {
                cardView.isHidden = true
            }
        }
    }
    
    /// 카드 개수에 따라 cardViewArray 내 cardView들의 frame을 업데이트
    private func configureCardViewsFrame(cardCount: Int) {
        let numberOfLines = Int(frame.size.height / LuckyCardView.Size.cardHeight)
        
        let verticalSpacing = (frame.size.height - LuckyCardView.Size.cardHeight * CGFloat(numberOfLines)) / CGFloat(numberOfLines + 1)
        
        var numberOfCardPerLine = CGFloat(cardCount / numberOfLines)
        if cardCount % numberOfLines != 0 {
            numberOfCardPerLine += 1
        }
        
        let horizontalSpacing = (frame.size.width - Size.cardViewInset*2 - LuckyCardView.Size.cardWidth*numberOfCardPerLine) / (numberOfCardPerLine - 1)
        
        for lineIndex in 0..<numberOfLines {
            let y = (LuckyCardView.Size.cardHeight + verticalSpacing) * CGFloat(lineIndex) + verticalSpacing
            for i in 0..<Int(numberOfCardPerLine) {
                let cardIndex = Int(numberOfCardPerLine) * lineIndex + i
                
                if cardIndex >= cardCount { continue }
                
                let x = Size.cardViewInset + (LuckyCardView.Size.cardWidth + horizontalSpacing) * CGFloat(i)
                cardViewArray[cardIndex].frame = CGRect(
                    x: x,
                    y: y,
                    width: LuckyCardView.Size.cardWidth,
                    height: LuckyCardView.Size.cardHeight
                )
            }
        }
    }
}

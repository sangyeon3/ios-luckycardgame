//
//  LuckyCardView.swift
//  LuckyCardGame
//
//  Created by 변상연 on 2023/07/09.
//

import UIKit

final class LuckyCardView: UIView {
    
    enum Size {
        static let cardHeight = 90.0
        static let cardWidth = cardHeight / 1.5858
        static let inset = 5.0
        static let numberLabelHeight = 15.0
        static let numberLabelFontSize = 15.0
        static let shapeLabelY = 25.0
        static let shapeLabelFontSize = 35.0
    }
    
    private let topNumberLabel: UILabel = {
        let label = UILabel(frame: .init(
            x: Size.inset,
            y: Size.inset,
            width: Size.cardWidth - Size.inset*2,
            height: Size.numberLabelHeight)
        )
        label.font = .boldSystemFont(ofSize: Size.numberLabelFontSize)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private let bottomNumberLabel: UILabel = {
        let label = UILabel(frame: .init(
            x: Size.inset,
            y: Size.cardHeight - (Size.numberLabelHeight + Size.inset),
            width: Size.cardWidth - Size.inset*2,
            height: Size.numberLabelHeight)
        )
        label.font = .boldSystemFont(ofSize: Size.numberLabelFontSize)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    private let shapeLabel: UILabel = {
        let label = UILabel(frame: .init(
            x: Size.inset,
            y: Size.shapeLabelY,
            width: Size.cardWidth - Size.inset*2,
            height: Size.cardHeight - Size.inset*2 - (Size.numberLabelHeight+Size.inset)*2)
        )
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 35)
        return label
    }()
    
    private let backLogoImage: UIImageView = {
        let imageView = UIImageView(frame: .init(
            x: Size.inset,
            y: Size.inset,
            width: Size.cardWidth - Size.inset*2,
            height: Size.cardHeight - Size.inset*2)
        )
        imageView.image = UIImage(named: "luckycard_back")
        imageView.isHidden = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        
        addSubview(topNumberLabel)
        addSubview(shapeLabel)
        addSubview(bottomNumberLabel)
        addSubview(backLogoImage)
    }
    
    /// 카드 모양과 숫자를 업데이트하고 앞뒷면 여부를 저장
    func update(for card: LuckyCard) {
        let cardInfo = card.fetchCardInfo()
        shapeLabel.text = cardInfo.shape.description
        topNumberLabel.text = String(cardInfo.number.rawValue)
        bottomNumberLabel.text = String(cardInfo.number.rawValue)
        backLogoImage.isHidden = cardInfo.isUp
    }
}



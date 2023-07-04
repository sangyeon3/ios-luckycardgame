//
//  PersonalCardBoardView.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/04.
//

import UIKit

final class PersonalCardBoardView: RoundView {
    
    private let alphabetLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 15, y: 20, width: 60, height: 60))
        label.textColor = .gray.withAlphaComponent(0.5)
        
        guard let fontDescriptor = UIFont.systemFont(ofSize: 40).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) else {
            return label
        }
        label.font = UIFont(descriptor: fontDescriptor, size: 40)
        return label
    }()
    
    init(frame: CGRect = .zero, alphabet: String) {
        super.init(frame: frame)
        
        alphabetLabel.text = alphabet
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        
        addSubview(alphabetLabel)
    }
}

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    convenience init(frame: CGRect = .zero, alphabet: String) {
        self.init(frame: frame)
        
        alphabetLabel.text = alphabet
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .systemGray5
        
        addSubview(alphabetLabel)
    }
}

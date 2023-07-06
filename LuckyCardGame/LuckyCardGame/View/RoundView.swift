//
//  RoundView.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/04.
//

import UIKit

class RoundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    private func configureUI() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
}

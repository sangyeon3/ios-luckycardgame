//
//  ViewController.swift
//  LuckyCardGame
//
//  Created by sangyeon on 2023/07/04.
//

import UIKit

class CardBoardViewController: UIViewController {
    
    struct UIConstants {
        static let stackViewWidth = 363.0
        static let stackViewSpacing = 10.0
        static let yellowViewHeigt = 44.0
        static let cardBoardHeight = 100.0
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = UIConstants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let topYellowView: RoundView = {
        let view = RoundView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let personalCardBoardViewArray = "ABCDE".map{ PersonalCardBoardView(alphabet: String($0)) }
    
    private let bottomView: RoundView = {
        let view = RoundView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(stackView)

        stackView.addArrangedSubview(topYellowView)
        personalCardBoardViewArray.forEach{
            stackView.addArrangedSubview($0)
        }
        stackView.addArrangedSubview(bottomView)
    }
    
    private func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: UIConstants.stackViewWidth).isActive = true
        
        topYellowView.heightAnchor.constraint(equalToConstant: UIConstants.yellowViewHeigt).isActive = true
        
        personalCardBoardViewArray.forEach{
            $0.heightAnchor.constraint(equalToConstant: UIConstants.cardBoardHeight).isActive = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}


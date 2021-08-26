//
//  CardView.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/26/21.
//

import UIKit

class CardView: UIView {
    static let cardHeight: CGFloat = 150
    static let cardWidth: CGFloat = 75
    
    var card: Card
    
    private lazy var stackView: UIStackView = {
        let topStack = UIStackView(arrangedSubviews: [suitRankStack(), UIView()])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        
        let bottomStack = UIStackView(arrangedSubviews: [UIView(), suitRankStack()])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .equalSpacing
        
        let stack = UIStackView(arrangedSubviews: [topStack, bottomStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func suitRankStack() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [rankLabel(), suitLabel()])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        return stack
    }
    
    private func suitLabel() -> UILabel {
        let label = UILabel()
        label.textColor = card.color
        label.text = card.suit.rawValue
        return label
    }
    
    private func rankLabel() -> UILabel {
        let label = UILabel()
        label.textColor = card.color
        label.text = card.rank.description
        return label
    }
    
    init(card: Card) {
        self.card = card
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("programmatic view")
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(stackView)
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Self.cardHeight),
            widthAnchor.constraint(equalToConstant: Self.cardWidth),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
            
        ])
    }
}

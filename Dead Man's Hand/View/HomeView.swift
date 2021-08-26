//
//  HomeView.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/26/21.
//

import UIKit

class HomeView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Dead Man's Hand"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("programmatic view")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        backgroundColor = .namedAsset(.feltColor)
        constraints()
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
}

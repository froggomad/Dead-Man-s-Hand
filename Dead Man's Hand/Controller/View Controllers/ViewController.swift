//
//  ViewController.swift
//  Dead Man's Hand
//
//  Created by Kenneth Dubroff on 8/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testDealHand()
    }
    
    private func testDealHand() {
        let game = PokerGame()
        game.drawHands()
        
        game.player1.hand!.cards.enumerated().forEach { index, card in
            let cardView = CardView(card: card)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(cardView)
            
            let spacing = CGFloat(4*index)
            NSLayoutConstraint.activate([
                cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CardView.cardWidth * CGFloat(index) + spacing)
            ])
        }
        
        let result = game.playHands()
        switch result {
        case let .win(rank, player):
            print("Player: \(player.name) wins with a \(rank.description)")
        case .tie:
            print("tied!")
        }
        print("Opponent's hand: \(game.ranker.rankHand(game.player2.hand!))", "with high card: \(game.ranker.highestCard(game.player2.hand!).rank)")
    }

}

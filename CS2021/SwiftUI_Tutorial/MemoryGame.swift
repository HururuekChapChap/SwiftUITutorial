//
//  MemoryGame.swift
//  SwiftUI_Tutorial
//
//  Created by TaeSoo Yoon on 2022/05/29.
//

import Foundation

//Model
struct MemoryGame<CardContent> {
    
    private(set) var cards : [Card] = []
    
    init(numberOfPairsOfCards : Int , createCardContent : (Int) -> CardContent ){
        self.cards = Array<Card>()
        //add numberOfPairsOfCard * 2 card to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content : CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
    }
    
    mutating func choose(_ card : Card) {
        guard let choosendIndex = self.index(of: card) else {return}
        cards[choosendIndex].isFaceUp.toggle()
        print("choosenCard = \(cards)")
    }
    
    func index(of card : Card) -> Int? {
        return cards.firstIndex(where: {$0.id == card.id})
    }
}

extension MemoryGame {
    struct Card : Identifiable {
        var isFaceUp : Bool = true
        var isMatched : Bool = false
        var content : CardContent
        var id: Int
    }
}

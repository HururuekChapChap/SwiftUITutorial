//
//  EmojiMemoryGame.swift
//  SwiftUI_Tutorial
//
//  Created by TaeSoo Yoon on 2022/05/29.
//

import Foundation
import SwiftUI


//ViewModel
//반응형 객체임을 ObservableObject로 표시한다.
class EmojiMemoryGame : ObservableObject{
    
    static let emojis : [String] = ["🤖","👻","🤢" ,"😹","🤮","🥶","😡","😰","😱","🤔","💩","👺","👿","👽","👳🏻","🧓🏾","😵","🥵"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: {index in EmojiMemoryGame.emojis[index] })
    }
    
    
    //private set mean other file can see property, but can't change
    //Published로 표현하여 해당 값이 변경 된다면 ObservableObject에서 일수 있도록 한다.
    @Published private var model : MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var card : [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card : MemoryGame<String>.Card ){
        model.choose(card)
    }
}

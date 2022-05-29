//
//  SwiftUI_TutorialApp.swift
//  SwiftUI_Tutorial
//
//  Created by TaeSoo Yoon on 2022/03/10.
//

import SwiftUI

@main
struct SwiftUI_TutorialApp: App {
    
    let game  = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}

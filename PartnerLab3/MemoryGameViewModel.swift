//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//

import SwiftUI
import Combine

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame = MemoryGame.createGame()
    
    // view reads cards from here
    var cards: [MemoryCard] {
        model.cards
    }
    
    func choose(_ card: MemoryCard) {
        // simple. actual animation is triggered in the View using withAnimation().
        model.choose(card)
    }
    
    func restart() {
        model = MemoryGame.createGame()
    }
}

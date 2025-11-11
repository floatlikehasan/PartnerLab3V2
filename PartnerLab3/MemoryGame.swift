//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//


import Foundation

struct MemoryGame {
    var cards: [MemoryCard]
    
    // this remembers if there is exactly one face up card
    private var indexOfFaceUpCard: Int? = nil
    
    mutating func choose(_ card: MemoryCard) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else {
            return
        }
        
        // ignore if already matched or already face up
        if cards[chosenIndex].isMatched || cards[chosenIndex].isFaceUp {
            return
        }
        
        // if we already have one card face up, try to match
        if let matchIndex = indexOfFaceUpCard {
            if cards[matchIndex].emoji == cards[chosenIndex].emoji {
                cards[matchIndex].isMatched = true
                cards[chosenIndex].isMatched = true
            }
            cards[chosenIndex].isFaceUp = true
            indexOfFaceUpCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            cards[chosenIndex].isFaceUp = true
            indexOfFaceUpCard = chosenIndex
        }
    }
    
    static func createGame() -> MemoryGame {
        let emojis = ["🍕","🍟","🌮","🍩","🍪","🍔"]
        var newCards: [MemoryCard] = []
        
        for emoji in emojis {
            newCards.append(MemoryCard(emoji: emoji))
            newCards.append(MemoryCard(emoji: emoji))
        }
        
        newCards.shuffle()
        return MemoryGame(cards: newCards)
    }
}


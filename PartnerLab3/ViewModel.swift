//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//
// ViewModel.swift
// Description: ViewModel that exposes cards to the UI and forwards user actions to the game model.


import SwiftUI
import Combine

class MemoryGameViewModel: ObservableObject {
    @Published private var model: MemoryGame = MemoryGame.createGame()
    
    //view reading cards logic
    var cards: [MemoryCard] {
        model.cards
    }
    
    func choose(_ card: MemoryCard) {
        //animation triggered in the View 
        model.choose(card)
    }
    
    func restart() {
        model = MemoryGame.createGame()
    }
}

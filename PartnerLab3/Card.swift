//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//
// Card.swift
// Description: Model for a single memory card, storing its emoji and flip/match state.



import Foundation

struct MemoryCard: Identifiable {
    let id = UUID()
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

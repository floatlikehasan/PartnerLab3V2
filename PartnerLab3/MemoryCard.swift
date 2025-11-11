//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//


import Foundation

struct MemoryCard: Identifiable {
    let id = UUID()
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

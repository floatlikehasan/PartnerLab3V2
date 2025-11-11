//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//

import SwiftUI

struct CardView: View {
    let card: MemoryCard
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            
            if card.isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                shape
                    .stroke(lineWidth: 2)
                Text(card.emoji)
                    .font(.largeTitle)
            } else {
                if card.isMatched {
                    // matched cards fade/scale out (handled below)
                    shape
                        .fill(Color.blue.opacity(0.3))
                } else {
                    shape
                        .fill()
                }
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .shadow(radius: 3)
        
        // Flip-style effect basic but looks cool
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.25), value: card.isFaceUp)
        
        .opacity(card.isMatched ? 0 : 1)
        .scaleEffect(card.isMatched ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: card.isMatched)
    }
}


//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//
// CardView.swift
// View for a single memory card, handling its visuals and flip animations.


import SwiftUI

struct CardView: View {
    let card: MemoryCard
    
    //dimensions of card
    private let radius: CGFloat = 10
    private let widthOfStroke: CGFloat = 5
    private let cardSize: CGFloat = 80   //square side length
    
    var body: some View {
        let shapeOfCardBase = RoundedRectangle(cornerRadius: radius)
        
        ZStack {
            if card.isFaceUp {
                cardWhenFlippedUP(using: shapeOfCardBase)
            } else {
                ifMatchedCard(using: shapeOfCardBase)
            }
        }
        .frame(width: cardSize, height: cardSize)
        .shadow(radius: 3)
        .scaleEffect(card.isFaceUp ? 0.95 : 0.9)
        .animation(.spring(response: 0.25, dampingFraction: 0.5), value: card.isFaceUp)
        .opacity(card.isMatched ? 0 : 1)
        .scaleEffect(card.isMatched ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.3), value: card.isMatched)
    }
        
    //card looks like when it's flipped over
    private func cardWhenFlippedUP(using shape: RoundedRectangle) -> some View {
        ZStack {
            Image("TextureOfCardWhenFlipped")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .clipShape(shape)
            
            shape
                .fill(Color.blue.opacity(0.3))
            
            shape
                .strokeBorder(Color.blue, lineWidth: widthOfStroke)
            
            Text(card.emoji)
                .font(.largeTitle)
        }
    }
    
    //this section here makes what the card looks like when it's face down or matched
    private func ifMatchedCard(using shape: RoundedRectangle) -> some View {
        let fillColor: Color = card.isMatched
            ? Color.cyan.opacity(0.3)
            : Color.cyan
        
        return shape
            .fill(fillColor)
    }
}


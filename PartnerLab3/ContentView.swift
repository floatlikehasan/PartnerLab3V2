//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//
// ContentView.swift
// Description: Main game screen: displays the header, 4×3 card grid, and restart button.


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MemoryGameViewModel()

    private let cardSize: CGFloat = 80

    var body: some View {
        ZStack {
            //Background
            Image("tropicalBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {

                //HEADER
                VStack(spacing: 4) {
                    Text("Frutiger Aero Match")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 8)

                    Text("Flip the glossy cards and match every icon to win!")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.85))
                }
                .padding(.top, 24)
                Spacer(minLength: 8)

                VStack(spacing: 12) {
                    ForEach(0..<4) { row in
                        HStack(spacing: 12) {
                            ForEach(0..<3) { column in
                                let index = row * 3 + column

                                if index < viewModel.cards.count {
                                    CardView(card: viewModel.cards[index])
                                        .frame(width: cardSize, height: cardSize)
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                viewModel.choose(viewModel.cards[index])
                                            }
                                        }
                                } else {
                                    // Keeps grid aligned if fewer than 12 cards
                                    Spacer()
                                        .frame(width: cardSize, height: cardSize)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // SHUFFLE button
                Button {
                    withAnimation(.easeInOut) {
                        viewModel.restart()
                    }
                } label: {
                    Text("Restart")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .padding(.horizontal, 32)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                }
                .padding(.bottom, 24)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


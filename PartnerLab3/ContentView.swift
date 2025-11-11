//
// Lab 3
// Group #3
// Hasan Dababo
// Date: 11/7/2025
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MemoryGameViewModel()

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // subtitle lives in safe area automatically
                Text("") // decided against having description
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    viewModel.choose(card)
                                }
                            }
                    }
                }
                .padding(.horizontal)

                Button("Shuffle Cards") {
                    withAnimation(.easeInOut) {
                        viewModel.restart()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.12))
                .cornerRadius(8)
                .padding(.bottom, 16)
            }
            .padding(.top, 8) // small breathing room under nav bar
            .navigationTitle("Snack Match")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

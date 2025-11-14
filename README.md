# Partner Lab 3 – Memory Game (Frutiger Aero Theme)

Group #3 – Hasan Dababo  
Date: 11/7/2025

## Overview

This project is a memory card game rebuilt using the MVVM architecture. The app displays 12 cards arranged in a fixed 4×3 grid. Each card shows an emoji when face up, and the goal is to find all the matching pairs.

The UI is styled with a Frutiger Aero–inspired look: bright background image, glossy-looking cards, rounded fonts, and simple, clean spacing. The focus of the project is on correct MVVM structure and basic, state-driven animations that make the interactions feel more responsive.

---

## MVVM Architecture

### Model (`MemoryGame.swift`, `MemoryCard.swift`)

- `MemoryCard`:
  - Represents a single card.
  - Stores:
    - `id` (UUID)
    - `emoji` (String)
    - `isFaceUp` (Bool)
    - `isMatched` (Bool)

- `MemoryGame`:
  - Stores an array of `MemoryCard` as `cards`.
  - Tracks the index of the one face-up card using `indexOfFaceUpCard`.
  - `mutating func choose(_ card: MemoryCard)`:
    - Finds the tapped card’s index.
    - Ignores taps on cards that are already matched or already face up.
    - If one other card is face up:
      - Compares emojis.
      - Marks both as matched if they are the same.
      - Sets the tapped card to face up and clears `indexOfFaceUpCard`.
    - If no card is currently the “one face up”:
      - Turns all cards face down.
      - Sets the tapped card to face up.
      - Updates `indexOfFaceUpCard` to the new index.
  - `static func createGame() -> MemoryGame`:
    - Uses six Frutiger Aero–style emojis.
    - Creates a pair of cards for each emoji (12 total).
    - Shuffles the cards and returns a new `MemoryGame`.

### ViewModel (`MemoryGameViewModel.swift`)

- `MemoryGameViewModel` conforms to `ObservableObject`.
- Holds the model in a `@Published private var model: MemoryGame`.
- Exposes `cards` as a computed property that returns `model.cards`.
- `func choose(_ card: MemoryCard)`:
  - Called by the view when a card is tapped.
  - Forwards the tap to `model.choose(card)`.
- `func restart()`:
  - Replaces the model with a new game from `MemoryGame.createGame()`.
- The ViewModel is the only layer that talks directly to the model. The views only interact with the ViewModel.

### View (`ContentView.swift`, `CardView.swift`)

- `ContentView`:
  - Owns `@StateObject private var viewModel = MemoryGameViewModel()`.
  - Uses a `NavigationStack` and a `ZStack` background image for the Frutiger Aero theme.
  - Displays:
    - A header with the game title and a one-line description.
    - A fixed 4×3 grid built with nested `ForEach` loops (4 rows, 3 columns).
    - Each card is shown using `CardView(card: viewModel.cards[index])`.
    - Each card is constrained to `80×80` points using `.frame(width: 80, height: 80)`.
    - A “Restart” button at the bottom, which calls `viewModel.restart()`.
  - Tap behavior:
    - Card taps are wrapped in `withAnimation(.easeInOut(duration: 0.25)) { viewModel.choose(card) }`.
    - Restart is wrapped in `withAnimation(.easeInOut) { viewModel.restart() }`.

- `CardView`:
  - Renders a single `MemoryCard`.
  - Uses a `RoundedRectangle` as the base shape.
  - When `card.isFaceUp` is true:
    - Draws a textured background image (`TextureOfCardWhenFlipped`).
    - Adds a semi-transparent blue overlay.
    - Adds a blue stroke border.
    - Draws the emoji in a large font.
  - When `card.isFaceUp` is false:
    - Fills the rounded rectangle in cyan.
    - Uses a lower opacity for matched cards to visually distinguish them.

---

## Animation / Transition Behavior

All animations are implemented in the View layer and are driven by changes in `card` state and ViewModel calls.

### Card tap animation (`CardView.swift`)

- Uses a scale animation tied to `card.isFaceUp`:
  - `scaleEffect(card.isFaceUp ? 0.95 : 0.9)`
  - `.animation(.spring(response: 0.25, dampingFraction: 0.5), value: card.isFaceUp)`
- This creates a small, spring-based scale change when a card flips between face up and face down.
- There is **no 3D flip rotation**. The visual effect is purely scale-based, not a flip.

### Matched card animation (`CardView.swift`)

- When `card.isMatched` becomes true:
  - `opacity` goes from `1` to `0`.
  - `scaleEffect` goes from `1.0` to `0.5`.
  - Both are animated with:
    - `.animation(.easeInOut(duration: 0.3), value: card.isMatched)`
- This makes matched cards smoothly shrink and fade out instead of disappearing instantly.

### Restart animation (`ContentView.swift`)

- The Restart button wraps `viewModel.restart()` in:
  - `withAnimation(.easeInOut) { ... }`
- This animates the grid update when a new shuffled game is created.

---

## Layout and Design

- 4×3 fixed grid of cards.
- Each card is an 80×80 square, so the grid stays aligned and does not shift when animations occur.
- Header text uses a rounded system font with a white foreground and a shadow to stand out from the background.
- Background is a full-screen image to match the Frutiger Aero style.
- Spacing is chosen so nothing overlaps the Dynamic Island or system UI on modern iPhones.

---

## Video

A walkthrough video explaining:
- How MVVM is implemented (Model, ViewModel, View separation).
- How the animations are wired to state (`isFaceUp`, `isMatched`) and where they are in the code.

[Paste video link here once recorded]

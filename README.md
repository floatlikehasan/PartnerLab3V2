# Frutiger Aero Memory Game — Partner Lab 3  
**Group #3 — Hasan Dababo**  
**Date: 11/7/2025**

## Overview  
This project is my rebuilt version of the Memory Card Game using the **MVVM architecture**, improved UI organization, and a custom transition/animation effect.  
I themed the entire app around a modern **Frutiger Aero aesthetic** with bright sky gradients, glossy textures, soft shadows, and clean rounded typography. The goal was to make the game feel light, smooth, and visually satisfying while keeping the code structure clean and modular.

The user flips over glossy cards and tries to match all the icons.  
I implemented a **smooth flip animation**.

---

## MVVM Architecture Breakdown  
I followed the MVVM pattern for this project:

### **Model — `MemoryGame.swift` / `MemoryCard.swift`**
The model handles:
- The list of cards
- Matching logic
- Flipping logic
- Resetting the game
- Tracking which card is face-up

---

### **ViewModel — `MemoryGameViewModel.swift`**
The ViewModel:
- Exposes `cards` to the view  
- Calls `model.choose()` when the user taps a card  
- Calls `model.restart()` to shuffle/reset  
- Uses `@Published` so the UI automatically updates  
- Acts as the “middleman” between UI and logic  
---

### **View — `ContentView.swift` + `CardView.swift`**
The View handles **UI only**, including:
- The grid layout (4 rows × 3 columns)
- Header text + description
- Background image
- Restart button
- Per-card animations
- Equal card sizing so the grid stays even

Each card is its own view (`CardView`) that reacts to:
- `isFaceUp`  
- `isMatched`  
- The ViewModel’s updates  

---

## Animation / Transition Implementation  
I added a smooth **flip animation** using SwiftUI’s `spring` and `easeInOut` effects.  
When the player taps a card:

- The card scales slightly (but keeps a perfectly square aspect ratio)
- The face texture fades in
- The border and glossy overlay appear smoothly
- Matched cards shrink and fade out

All animations are placed inside the View layer (`CardView`), triggered using:

```swift
withAnimation(.easeInOut(duration: 0.25)) { ... }

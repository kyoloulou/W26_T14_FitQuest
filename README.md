# FitQuest 🏃‍♂️
**Health & Fitness Mobile App — COMP3097 | Team T14 | Trung Anh Nguyen**

## Overview
FitQuest is an iOS fitness tracking app built with Swift and SwiftUI. It allows users to register an account, browse and start pre-built workouts, track calorie burn with a live timer, view workout history with a progress chart, calculate calories burned, and manage their profile — all stored locally with no backend required.

## Features
| Feature | Description |
|---|---|
| Login / Register | Local auth with Keychain — email + password, validation, error messages |
| Workout List | 4 pre-built workouts (Running, Cycling, Push-ups, Squats) |
| Start Workout | Live timer with real-time calorie tracking |
| Save History | Sessions saved locally with swipe-to-delete |
| Progress Chart | Bar chart showing calories burned per session (last 10) |
| Calorie Calculator | Estimate calories for cardio (minutes + speed) or strength (reps + sets) |
| Profile Screen | Stats summary, account info, and sign out |

## Requirements
- macOS 13.0 (Ventura) or later
- Xcode 15.0 or later
- iOS 17.0 Simulator (included with Xcode)
- No external dependencies or Swift Packages required

## How to Run
1. Clone or download this repository
2. Open `FitQuestT14.xcodeproj` in Xcode
3. Select a simulator — **iPhone 15 Pro** (iOS 17+) recommended
4. Press **Cmd + R** to build and run
5. No internet connection or backend server needed

## Login Info
FitQuest uses **local authentication** — accounts are stored securely on device via iOS Keychain.

- On first launch, tap **"Don't have an account? Sign Up"**
- Register with any valid email and a password of 8+ characters
- You will be logged in automatically after registering

**Demo account (register once on first launch):**
| | |
|---|---|
| Email | `demo@fitquest.com` |
| Password | `password123` |

## Project Structure
- `AuthStore.swift` — Login, register, sign out logic
- `CalorieCalculator.swift` — Calorie calculation formulas
- `CalorieCalculatorView.swift` — Calorie calculator UI tab
- `ContentView.swift` — Main TabView (Workouts, Calculator, Profile)
- `FitQuestT14App.swift` — App entry point
- `KeychainHelper.swift` — Secure Keychain wrapper
- `LoginView.swift` — Login and registration screen
- `ProfileView.swift` — Profile screen with stats
- `RootView.swift` — Routes between Login and Main
- `SessionRow.swift` — Workout history row
- `StatBadge.swift` — Stat badge component
- `TimerHolder.swift` — Workout timer logic
- `ValidatedField.swift` — Reusable validated text field
- `Workout.swift` — Data models
- `WorkoutDetailView.swift` — Active workout screen
- `WorkoutRow.swift` — Workout list row
- `WorkoutStore.swift` — Session persistence

## Notes
- All data is stored locally — no internet required
- Accounts persist across simulator sessions via Keychain + UserDefaults
- To reset all data: **Device → Erase All Content and Settings** in the simulator
- Community Challenges feature was planned but excluded to maintain quality as a single-member team

## Tech Stack
- **SwiftUI** — UI framework
- **Charts** — native bar chart for progress screen
- **Security / Keychain** — secure password storage
- **Foundation / UserDefaults** — local session persistence

---
*COMP3097 — George Brown College — Winter 2026*

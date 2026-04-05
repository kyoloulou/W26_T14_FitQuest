//
//  CalorieCalculatorView.swift
//  FitQuestT14
//
//  Created by Trung Anh Nguyen on 2026-04-05.
//

import SwiftUI

struct CalorieCalculatorView: View {

    // Shared segment
    @State private var selectedType: WorkoutType = .cardio

    // Cardio inputs
    @State private var minutes: String = ""
    @State private var speed:   String = ""

    // Strength inputs
    @State private var reps: String = ""
    @State private var sets: String = ""

    // Result
    @State private var result: Double? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // ── Picker ─────────────────────────────────────
                    Picker("Workout Type", selection: $selectedType) {
                        Text("Cardio").tag(WorkoutType.cardio)
                        Text("Strength").tag(WorkoutType.strength)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedType) { _ in result = nil }

                    // ── Inputs ─────────────────────────────────────
                    VStack(spacing: 14) {
                        if selectedType == .cardio {
                            InputField(label: "Duration (minutes)", text: $minutes, placeholder: "e.g. 30")
                            InputField(label: "Speed (km/h)", text: $speed, placeholder: "e.g. 8")
                        } else {
                            InputField(label: "Reps per set", text: $reps, placeholder: "e.g. 12")
                            InputField(label: "Number of sets", text: $sets, placeholder: "e.g. 4")
                        }
                    }

                    // ── Calculate Button ───────────────────────────
                    Button {
                        calculate()
                    } label: {
                        Text("Calculate")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .font(.headline)
                    }

                    // ── Result ─────────────────────────────────────
                    if let result {
                        VStack(spacing: 8) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.orange)
                            Text("\(Int(result)) kcal")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.primary)
                            Text("estimated calories burned")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .transition(.scale.combined(with: .opacity))
                    }

                    Spacer()
                }
                .padding()
                .animation(.easeInOut, value: result)
            }
            .navigationTitle("Calorie Calculator")
        }
    }

    private func calculate() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
        if selectedType == .cardio {
            guard let m = Double(minutes), let s = Double(speed), m > 0, s > 0 else { return }
            result = CalorieCalculator.cardio(minutes: m, speed: s)
        } else {
            guard let r = Double(reps), let s = Double(sets), r > 0, s > 0 else { return }
            result = CalorieCalculator.strength(reps: r, sets: s)
        }
    }
}

// MARK: - Reusable input field
private struct InputField: View {
    let label: String
    @Binding var text: String
    let placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField(placeholder, text: $text)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
        }
    }
}

//
//  ProfileView.swift
//  FitQuestT14
//
//  Created by Trung Anh Nguyen on 2026-04-05.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthStore
    @EnvironmentObject var store: WorkoutStore

    // MARK: - Computed Stats
    private var totalSessions: Int {
        store.sessions.count
    }

    private var totalCalories: Double {
        store.sessions.reduce(0) { $0 + $1.calories }
    }

    private var lastWorkoutDate: String {
        guard let latest = store.sessions.map({ $0.date }).max() else {
            return "No workouts yet"
        }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: latest, relativeTo: Date())
    }

    private var favoriteWorkout: String {
        guard !store.sessions.isEmpty else { return "—" }
        let counts = Dictionary(grouping: store.sessions, by: { $0.name })
            .mapValues { $0.count }
        return counts.max(by: { $0.value < $1.value })?.key ?? "—"
    }

    private var avatarLetter: String {
        String(auth.currentEmail.prefix(1)).uppercased()
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // ── Avatar + Email ──────────────────────────────────────
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.15))
                                .frame(width: 90, height: 90)
                            Text(avatarLetter)
                                .font(.system(size: 38, weight: .bold))
                                .foregroundColor(.blue)
                        }

                        Text(auth.currentEmail)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                    .padding(.top, 16)

                    // ── Stats Grid ─────────────────────────────────────────
                    SectionHeader(title: "My Stats", systemImage: "chart.bar.fill")

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ProfileStatCard(
                            icon: "flame.fill",
                            iconColor: .orange,
                            label: "Total Burned",
                            value: "\(Int(totalCalories)) kcal"
                        )
                        ProfileStatCard(
                            icon: "figure.run",
                            iconColor: .blue,
                            label: "Sessions",
                            value: "\(totalSessions)"
                        )
                        ProfileStatCard(
                            icon: "star.fill",
                            iconColor: .yellow,
                            label: "Favourite",
                            value: favoriteWorkout
                        )
                        ProfileStatCard(
                            icon: "clock.fill",
                            iconColor: .green,
                            label: "Last Workout",
                            value: lastWorkoutDate
                        )
                    }

                    // ── Account Section ────────────────────────────────────
                    SectionHeader(title: "Account", systemImage: "person.fill")

                    VStack(spacing: 0) {
                        ProfileInfoRow(label: "Email", value: auth.currentEmail)
                        Divider().padding(.leading, 16)
                        ProfileInfoRow(label: "Member Since", value: memberSinceDate)
                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                    // ── Sign Out ───────────────────────────────────────────
                    Button(role: .destructive) {
                        auth.signOut()
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign Out")
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .foregroundColor(.red)
                        .cornerRadius(12)
                    }
                    .padding(.bottom, 16)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Profile")
        }
    }

    // Approximate member-since using first session date or today
    private var memberSinceDate: String {
        let date = store.sessions.map({ $0.date }).min() ?? Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

// MARK: - Subviews

private struct ProfileStatCard: View {
    let icon: String
    let iconColor: Color
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(iconColor)
            Text(value)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

private struct ProfileInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

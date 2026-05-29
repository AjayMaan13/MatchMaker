//
//  ContentView.swift
//  MatchMaker
//
//  Created by Ajaypartap Singh Maan on 2026-05-28.
//

import SwiftUI

// MARK: - Data Model

/// Feedback for a single peg in a CodeBreaker guess.
enum Match {
    case exact      // right color, right position
    case inexact    // right color, wrong position
    case nomatch    // color not in the secret code
}

// MARK: - Atomic Views

/// A single colored peg the player places on the board.
struct Peg: View {
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
    }
}

// MARK: - Composite View

/// Renders the feedback grid for a guess.
/// Accepts 3–6 `Match` values and adapts the layout:
///   3 or 4 matches → 2×2 grid
///   5 or 6 matches → 2×3 grid
struct MatchMarkers: View {
    let matches: Array<Match>

    var body: some View {
        VStack {
            if matches.count <= 4 {
                // 2×2 layout
                HStack {
                    marker(for: matches[0])
                    marker(for: matches[1])
                }
                HStack {
                    marker(for: matches[2])
                    if matches.count > 3 {
                        marker(for: matches[3])
                    }
                }
            } else {
                // 2×3 layout
                HStack {
                    marker(for: matches[0])
                    marker(for: matches[1])
                    marker(for: matches[2])
                }
                HStack {
                    marker(for: matches[3])
                    marker(for: matches[4])
                    if matches.count > 5 {
                        marker(for: matches[5])
                    }
                }
            }
        }
        // Keep the whole grid square regardless of how many markers it holds.
        .aspectRatio(1, contentMode: .fit)
    }

    /// Maps a single `Match` value to its visual representation.
    /// `.nomatch` renders as a clear circle so it still occupies a grid slot.
    @ViewBuilder
    func marker(for match: Match) -> some View {
        switch match {
        case .exact:
            Circle()
                .fill(.primary)
        case .inexact:
            Circle()
                .strokeBorder(.primary, lineWidth: 2)
        case .nomatch:
            Circle()
                .fill(.clear)
        }
    }
}

// MARK: - App Entry View

struct ContentView: View {
    var body: some View {
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
            .frame(width: 120, height: 120)
            .padding()
    }
}

// MARK: - Preview Helpers

/// "Helicopter" view used only by `#Preview`.
/// Pairs a row of dummy `Peg`s with the `MatchMarkers` they correspond to,
/// so the markers can be seen in their native environment.
/// Both the pegs and the markers are driven by the same `matches` array,
/// guaranteeing the peg count always equals the marker count.
struct MatchMarkersPreview: View {
    let matches: Array<Match>

    private let pegColors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]

    var body: some View {
        HStack(spacing: 12) {
            HStack {
                ForEach(0..<matches.count, id: \.self) { index in
                    Peg(color: pegColors[index])
                        .frame(width: 40, height: 40)
                }
            }
            MatchMarkers(matches: matches)
                .frame(width: 80, height: 80)
        }
        .padding(.horizontal)
    }
}

// MARK: - Previews

#Preview("Light Mode") {
    VStack(spacing: 16) {
        MatchMarkersPreview(matches: [.exact, .inexact, .nomatch])
        MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .exact])
        MatchMarkersPreview(matches: [.exact, .exact, .inexact, .nomatch, .exact])
        MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .exact, .inexact, .nomatch])
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack(spacing: 16) {
        MatchMarkersPreview(matches: [.nomatch, .inexact, .exact])
        MatchMarkersPreview(matches: [.inexact, .inexact, .inexact, .inexact])
        MatchMarkersPreview(matches: [.exact, .exact, .exact, .exact, .exact])
        MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .nomatch, .inexact, .exact])
    }
    .preferredColorScheme(.dark)
}

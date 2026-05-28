//
//  ContentView.swift
//  MatchMaker
//
//  Created by Ajaypartap Singh Maan on 2026-05-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
            .frame(width: 120, height: 120)
            .padding()
    }
}

enum Match {
    case exact
    case inexact
    case nomatch
}

struct MatchMarkers: View {
    let matches: Array<Match>

    var body: some View {
        VStack {
            if matches.count <= 4 {
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
        .aspectRatio(1, contentMode: .fit)
    }

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

struct Peg: View {
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
    }
}

#Preview {
    VStack(spacing: 20) {
        MatchMarkers(matches: [.exact, .inexact, .nomatch])
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact, .inexact])
        MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact, .inexact, .nomatch])
    }
    .frame(width: 120)
    .padding()
}

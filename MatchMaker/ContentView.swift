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
            HStack {
                marker(for: matches[0])
                marker(for: matches[1])
            }
            HStack {
                marker(for: matches[2])
                marker(for: matches[3])
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
    ContentView()
}

//
//  ContentView.swift
//  Shared
//
//  Created by Scotti on 8/30/22.
//

import SwiftUI
import ShuffleStack

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .yellow, .green, .blue, Color(.systemIndigo)]
    @State private var isNothing = true
    var body: some View {
        ScrollView {
            ShuffleStack(colors) { color in
                Group {
                    if isNothing {
                        CardView(color: color)
                    } else {
                        CardView(color: color)
                            .overlay(Text("Nothing"))
                    }
                }
                .onTapGesture {
                    isNothing.toggle()
                }
            }
            .frame(height: 200)
            .padding(.horizontal, 20)
            .shuffleStackStyle(.rotateOut)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    let color: Color
    var body: some View {
        color
            .frame(height: 200)
            .cornerRadius(10)
    }
}

extension Color: Identifiable {
    public var id: Int {
        self.cgColor.hashValue
    }
}

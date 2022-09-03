//
//  ContentView.swift
//  Shared
//
//  Created by Scotti on 8/30/22.
//

import SwiftUI
import Combine
import ShuffleStack

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .yellow, .green, .gray, Color(.systemIndigo)]
    let sufflingPublisher = PassthroughSubject<Direction, Never>()
    var body: some View {
        ScrollView {
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .shuffleAnimation(.easeInOut)
            .stackOffset(30)
            .stackPadding(30)
            .onShuffle(sufflingPublisher)
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .swipeDisabled(true)
            .onShuffle(sufflingPublisher)
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .shuffleStyle(.rotateIn)
            .shuffleAnimation(.easeIn)
            .onShuffle(sufflingPublisher)
            ShuffleStack(colors) { color in
                CardView(color: color)
                    .onTapGesture {
                        sufflingPublisher.send(.right)
                    }
            }
            .shuffleStyle(.rotateOut)
            .stackOffset(20)
            .onShuffle(sufflingPublisher)
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
        VStack {
            Text("Hello")
                .padding(100)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(color)
        .cornerRadius(10)
    }
}

extension Color: Identifiable {
    public var id: Int {
        self.cgColor.hashValue
    }
}

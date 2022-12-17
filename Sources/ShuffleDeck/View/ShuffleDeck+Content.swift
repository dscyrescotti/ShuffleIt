import SwiftUI

extension ShuffleDeck {
    @ViewBuilder
    internal var mainContent: some View {
        if let element = data[safe: index] {
            content(element, 0)
                .scaleEffect(1 - scale * min(abs(xPosition / 10), 5))
                .rotationEffect(.degrees(min(max(xPosition / 10, -10), 10)))
                .offset(x: xPosition * 1.2)
                .zIndex(100)
        }
    }

    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement(1) {
            let factor = translation - translation * 0.4
            content(element, translation)
                .scaleEffect(1 - scale + factor * scale, anchor: .bottomLeading)
                .rotationEffect(.degrees(-2 + Double(factor) * 2), anchor: .bottomLeading)
                .offset(x: -3 + factor * 2, y: -5 - abs(factor) * 5)
                .zIndex(direction == .left ? 2 : 1)
        }
    }

    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement(1) {
            let factor = translation - translation * 0.4
            content(element, translation)
                .scaleEffect(1 - scale + (-factor) * scale, anchor: .bottomTrailing)
                .rotationEffect(.degrees(2 + Double(factor) * 2), anchor: .bottomTrailing)
                .offset(x: 3 + factor * 2, y: -5 - abs(factor) * 5)
                .zIndex(direction == .right ? 2 : 1)
        }
    }

    @ViewBuilder
    internal var secondLeftContent: some View {
        if let element = leftDataElement(2) {
           let factor = translation - translation * 0.4
            content(element, translation)
                .scaleEffect(1 - (scale * 2) + (factor * scale), anchor: .bottomLeading)
                .rotationEffect(.degrees(-4 + Double(factor) * 2), anchor: .bottomLeading)
                .offset(x: -5 + factor * 2, y: -10 - abs(factor) * 5)
        }
    }

    @ViewBuilder
    internal var secondRightContent: some View {
        if let element = rightDataElement(2) {
            let factor = translation - translation * 0.4
            let scaleFactor = (-scale * 2) + ((-factor) * scale)
            content(element, translation)
                .scaleEffect(1 + scaleFactor, anchor: .bottomTrailing)
                .rotationEffect(.degrees(4 + Double(factor) * 2), anchor: .bottomTrailing)
                .offset(x: 5 + factor * 2, y: -10 - abs(factor) * 5)
        }
    }

    @ViewBuilder
    internal var thirdLeftContent: some View {
        if let element = leftDataElement(3) {
            let factor = translation - translation * 0.4
            content(element, translation)
                .scaleEffect(1 - (scale * 3) + (factor * scale), anchor: .bottomLeading)
                .rotationEffect(.degrees(-6 + Double(factor) * 2), anchor: .bottomLeading)
                .offset(x: -7 + factor * 2, y: -15 - abs(factor) * 5)
        }
    }

    @ViewBuilder
    internal var thirdRightContent: some View {
        if let element = rightDataElement(3) {
            let factor = translation - translation * 0.4
            let scaleFactor = (-scale * 3) + ((-factor) * scale)
            content(element, translation)
                .scaleEffect(1 + scaleFactor, anchor: .bottomTrailing)
                .rotationEffect(.degrees(6 + Double(factor) * 2), anchor: .bottomTrailing)
                .offset(x: 7 + factor * 2, y: -15 - abs(factor) * 5)
        }
    }

    @ViewBuilder
    internal var fourthLeftContent: some View {
        if let element = leftDataElement(4) {
            let factor = translation - translation * 0.4
            content(element, 0)
                .scaleEffect(1 - (scale * 4)  + (factor * scale), anchor: .bottomLeading)
                .rotationEffect(.degrees(-8 + Double(factor) * 2), anchor: .bottomLeading)
                .offset(x: -9 + factor * 2, y: -20 - abs(factor) * 5)
        }
    }

    @ViewBuilder
    internal var fourthRightContent: some View {
        if let element = rightDataElement(4) {
            let factor = translation - translation * 0.4
            let scaleFactor = (-scale * 4) + ((-factor) * scale)
            content(element, 0)
                .scaleEffect(1 + scaleFactor, anchor: .bottomTrailing)
                .rotationEffect(.degrees(8 + Double(factor) * 2), anchor: .bottomTrailing)
                .offset(x: 9 + factor * 2, y: -20 - abs(factor) * 5)
        }
    }
}

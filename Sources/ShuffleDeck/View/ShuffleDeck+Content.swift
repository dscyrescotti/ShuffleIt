import SwiftUI

extension ShuffleDeck {
    @ViewBuilder
    internal var mainContent: some View {
        if let element = data[safe: index] {
            let factor: CGFloat = factor * 4
            let anchor: UnitPoint = direction == .left ? .bottomTrailing : .bottomLeading
            let scale: CGFloat = isLockedLeft || isLockedRight ? 1 - scale : 1 - scale * (direction == .left ? 1 : -1) * factor
            let degree: Double = isLockedLeft ? 2 : isLockedRight ? -2 : Double(factor) * 2
            let xOffset: CGFloat = isLockedLeft ? 3 : isLockedRight ? -3 : xPosition * 0.8
            let yOffset: CGFloat = isLockedLeft || isLockedRight ? -5 : -5 * abs(factor)
            let index: Double = isLockedLeft || isLockedRight ? 2 : 10
            content(element, translation)
                .scaleEffect(scale, anchor: anchor)
                .rotationEffect(.degrees(degree), anchor: anchor)
                .offset(x: xOffset, y: yOffset)
                .zIndex(index)
        }
    }

    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement(1) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = 1 - scale + factor * scale
            let degree: Double = -2 + Double(factor) * 2
            let xOffset: CGFloat = -3 + factor * 2
            let yOffset: CGFloat = -5 + factor * 5
            let index: Double = direction == .left ? 3 : 1
            content(element, translation)
                .scaleEffect(scale, anchor: .bottomLeading)
                .rotationEffect(.degrees(degree), anchor: .bottomLeading)
                .offset(x: xOffset, y: yOffset)
                .zIndex(index)
        }
    }

    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement(1) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = 1 - scale + (-factor) * scale
            let degree: Double = 2 + Double(factor) * 2
            let xOffset: CGFloat = 3 + factor * 2
            let yOffset: CGFloat = -5 - factor * 5
            let index: Double = direction == .right ? 3 : 1
            content(element, translation)
                .scaleEffect(scale, anchor: .bottomTrailing)
                .rotationEffect(.degrees(degree), anchor: .bottomTrailing)
                .offset(x: xOffset, y: yOffset)
                .zIndex(index)
        }
    }

    @ViewBuilder
    internal var secondLeftContent: some View {
        if let element = leftDataElement(2) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = 1 - (scale * 2) + (factor * scale)
            let degree: Double = -4 + Double(factor) * 2
            let xOffset: CGFloat = -5 + factor * 2
            let yOffset: CGFloat = -10 + factor * 5
            content(element, translation)
                .scaleEffect(scale, anchor: .bottomLeading)
                .rotationEffect(.degrees(degree), anchor: .bottomLeading)
                .offset(x: xOffset, y: yOffset)
        }
    }

    @ViewBuilder
    internal var secondRightContent: some View {
        if let element = rightDataElement(2) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = 1 + (-scale * 2) - (factor * scale)
            let degree: Double = 4 + Double(factor) * 2
            let xOffset: CGFloat = 5 + factor * 2
            let yOffset: CGFloat = -10 - factor * 5
            content(element, translation)
                .scaleEffect(scale, anchor: .bottomTrailing)
                .rotationEffect(.degrees(degree), anchor: .bottomTrailing)
                .offset(x: xOffset, y: yOffset)
        }
    }

    @ViewBuilder
    internal var thirdLeftContent: some View {
        if let element = leftDataElement(3) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = 1 - (scale * 3) + (factor * scale)
            let degree: Double = -6 + Double(factor) * 2
            let xOffset: CGFloat = -7 + factor * 2
            let yOffset: CGFloat = -15 + factor * 5
            content(element, translation)
                .scaleEffect(scale, anchor: .bottomLeading)
                .rotationEffect(.degrees(degree), anchor: .bottomLeading)
                .offset(x: xOffset, y: yOffset)
        }
    }

    @ViewBuilder
    internal var thirdRightContent: some View {
        if let element = rightDataElement(3) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = 1 + (-scale * 3) - (factor * scale)
            let degree: Double = 6 + Double(factor) * 2
            let xOffset: CGFloat = 7 + factor * 2
            let yOffset: CGFloat = -15 - factor * 5
            content(element, translation)
                .scaleEffect(scale, anchor: .bottomTrailing)
                .rotationEffect(.degrees(degree), anchor: .bottomTrailing)
                .offset(x: xOffset, y: yOffset)
        }
    }

    @ViewBuilder
    internal var fourthLeftContent: some View {
        if let element = leftDataElement(4) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = isShiftedLeft ? 1 - (scale * 4) : 1 - (scale * 4)  + (factor * scale)
            let degree: Double = isShiftedLeft ? 8 : -8 + Double(factor) * 2
            let anchor: UnitPoint = isShiftedLeft ? .bottomTrailing : .bottomLeading
            let xOffset: CGFloat = isShiftedLeft ? 9 : -9 + factor * 2
            let yOffset: CGFloat = isShiftedLeft ? -20 : -20 + factor * 5
            let index: Double = isShiftedLeft ? -1 : 0
            content(element, 0)
                .scaleEffect(scale, anchor: anchor)
                .rotationEffect(.degrees(degree), anchor: anchor)
                .offset(x: xOffset, y: yOffset)
                .zIndex(index)
        }
    }

    @ViewBuilder
    internal var fourthRightContent: some View {
        if let element = rightDataElement(4) {
            let factor: CGFloat = direction == .left ? max(0, factor - 0.2) : min(0, factor + 0.2)
            let scale: CGFloat = isShiftedRight ? 1 - (scale * 4) : 1 - (scale * 4) - (factor * scale)
            let degree: Double = isShiftedRight ? -8 : 8 + Double(factor) * 2
            let anchor: UnitPoint = isShiftedRight ? .bottomLeading : .bottomTrailing
            let xOffset: CGFloat = isShiftedRight ? -9 : 9 + factor * 2
            let yOffset: CGFloat = isShiftedRight ? -20 : -20 - factor * 5
            let index: Double = isShiftedRight ? -1 : 0
            content(element, 0)
                .scaleEffect(scale, anchor: anchor)
                .rotationEffect(.degrees(degree), anchor: anchor)
                .offset(x: xOffset, y: yOffset)
                .zIndex(index)
        }
    }
}

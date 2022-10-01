import SwiftUI

extension ShuffleStack {
    /// A view that renders the content view for the element of the previous index.
    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement {
            switch style {
            case .slide:
                stackContent(element, translation)
                    .offset(x: xPosition > 0 ? -offset - xPosition : -offset, y: 0)
                    .scaleEffect(xPosition > 0 ? scale + (xPosition / size.width * 0.01) : scale, anchor: .leading)
                    .zIndex(direction == .right ? 1 : 3)
            case .rotateIn:
                stackContent(element, translation)
                    .offset(x: xPosition > 0 ? -offset - xPosition : -offset, y: 0)
                    .scaleEffect(xPosition > 0 ? 1 : scale, anchor: .leading)
                    .rotation3DEffect(
                        xPosition > 0 ? .degrees(0 + Double(xPosition) / offset) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .zIndex(direction == .right ? 1 : 3)
            case .rotateOut:
                stackContent(element, translation)
                    .offset(x: xPosition > 0 ? -offset - xPosition : -offset, y: 0)
                    .scaleEffect(xPosition > 0 ? 1 : scale, anchor: .leading)
                    .rotation3DEffect(
                        xPosition > 0 ? .degrees(0 - Double(xPosition) / offset) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .zIndex(direction == .right ? 1 : 3)
            }
        }
    }
    
    /// A view that renders the content view for the element of the next index.
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement {
            switch style {
            case .slide:
                stackContent(element, translation)
                    .offset(x: xPosition < 0 ? offset - xPosition : offset, y: 0)
                    .scaleEffect(xPosition < 0 ? scale + (-xPosition / size.width * 0.01) : scale, anchor: .trailing)
                    .zIndex(direction == .left ? 1 : 3)
            case .rotateIn:
                stackContent(element, translation)
                    .offset(x: xPosition < 0 ? offset - xPosition : offset, y: 0)
                    .scaleEffect(xPosition < 0 ? 1 : scale, anchor: .trailing)
                    .rotation3DEffect(
                        xPosition < 0 ? .degrees(0 + Double(xPosition) / offset) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .zIndex(direction == .left ? 1 : 3)
            case .rotateOut:
                stackContent(element, translation)
                    .offset(x: xPosition < 0 ? offset - xPosition : offset, y: 0)
                    .scaleEffect(xPosition < 0 ? 1 : scale, anchor: .trailing)
                    .rotation3DEffect(
                        xPosition < 0 ? .degrees(0 - Double(xPosition) / offset) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .zIndex(direction == .left ? 1 : 3)
            }
        }
    }
    
    /// A view that renders the content view for the element of the current index.
    @ViewBuilder
    internal var mainContent: some View {
        if let element = data[safe: index] {
            switch style {
            case .slide:
                stackContent(element, translation)
                    .zIndex(4)
                    .offset(x: xPosition, y: 0)
            case .rotateIn:
                stackContent(element, translation)
                    .zIndex(4)
                    .offset(x: xPosition, y: 0)
                    .rotation3DEffect(
                        .degrees(0 + Double(-xPosition) / offset),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            case .rotateOut:
                stackContent(element, translation)
                    .zIndex(4)
                    .offset(x: xPosition, y: 0)
                    .rotation3DEffect(
                        .degrees(0 - Double(-xPosition) / offset),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            }
        }
    }
}

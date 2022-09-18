import SwiftUI

extension ShuffleStack {
    /// A view that renders the content view for the element of the previous index.
    @ViewBuilder
    internal var leftContent: some View {
        switch style {
        case .slide:
            stackContent(leftDataElement, translation)
                .offset(x: xPosition > 0 ? -offset - xPosition : -offset, y: 0)
                .scaleEffect(xPosition > 0 ? scale + (xPosition / size.width * 0.01) : scale, anchor: .leading)
                .zIndex(direction == .right ? 1 : 3)
        case .rotateIn:
            stackContent(leftDataElement, translation)
                .offset(x: xPosition > 0 ? -offset - xPosition : -offset, y: 0)
                .scaleEffect(xPosition > 0 ? 1 : scale, anchor: .leading)
                .rotation3DEffect(
                    xPosition > 0 ? .degrees(0 + Double(xPosition) / offset) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .right ? 1 : 3)
        case .rotateOut:
            stackContent(leftDataElement, translation)
                .offset(x: xPosition > 0 ? -offset - xPosition : -offset, y: 0)
                .scaleEffect(xPosition > 0 ? 1 : scale, anchor: .leading)
                .rotation3DEffect(
                    xPosition > 0 ? .degrees(0 - Double(xPosition) / offset) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .right ? 1 : 3)
        }
    }
    
    /// A view that renders the content view for the element of the next index.
    @ViewBuilder
    internal var rightContent: some View {
        switch style {
        case .slide:
            stackContent(rightDataElement, translation)
                .offset(x: xPosition < 0 ? offset - xPosition : offset, y: 0)
                .scaleEffect(xPosition < 0 ? scale + (-xPosition / size.width * 0.01) : scale, anchor: .trailing)
                .zIndex(direction == .left ? 1 : 3)
        case .rotateIn:
            stackContent(rightDataElement, translation)
                .offset(x: xPosition < 0 ? offset - xPosition : offset, y: 0)
                .scaleEffect(xPosition < 0 ? 1 : scale, anchor: .trailing)
                .rotation3DEffect(
                    xPosition < 0 ? .degrees(0 + Double(xPosition) / offset) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .left ? 1 : 3)
        case .rotateOut:
            stackContent(rightDataElement, translation)
                .offset(x: xPosition < 0 ? offset - xPosition : offset, y: 0)
                .scaleEffect(xPosition < 0 ? 1 : scale, anchor: .trailing)
                .rotation3DEffect(
                    xPosition < 0 ? .degrees(0 - Double(xPosition) / offset) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .left ? 1 : 3)
        }
    }
    
    /// A view that renders the content view for the element of the current index.
    @ViewBuilder
    internal var mainContent: some View {
        switch style {
        case .slide:
            stackContent(data[index], translation)
                .zIndex(4)
                .offset(x: xPosition, y: 0)
        case .rotateIn:
            stackContent(data[index], translation)
                .zIndex(4)
                .offset(x: xPosition, y: 0)
                .rotation3DEffect(
                    .degrees(0 + Double(-xPosition) / offset),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        case .rotateOut:
            stackContent(data[index], translation)
                .zIndex(4)
                .offset(x: xPosition, y: 0)
                .rotation3DEffect(
                    .degrees(0 - Double(-xPosition) / offset),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        }
    }
}

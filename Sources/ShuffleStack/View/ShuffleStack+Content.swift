import SwiftUI

// MARK: - Content
extension ShuffleStack {
    @ViewBuilder
    internal func leftContent(_ proxy: GeometryProxy) -> some View {
        switch style {
        case .slide:
            stackContent(leftDataElement)
                .offset(x: xPosition > 0 ? -15 - xPosition : -15, y: 0)
                .scaleEffect(xPosition > 0 ? 0.95 + (xPosition / proxy.midXPercentage * 0.01) : 0.95)
                .zIndex(direction == .right ? 1 : 3)
        case .rotateIn:
            stackContent(leftDataElement)
                .offset(x: xPosition > 0 ? -15 - xPosition : -15, y: 0)
                .scaleEffect(xPosition > 0 ? 1 : 0.95)
                .rotation3DEffect(
                    xPosition > 0 ? .degrees(0 + Double(xPosition) / 15) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .right ? 1 : 3)
        case .rotateOut:
            stackContent(leftDataElement)
                .offset(x: xPosition > 0 ? -15 - xPosition : -15, y: 0)
                .scaleEffect(xPosition > 0 ? 1 : 0.95)
                .rotation3DEffect(
                    xPosition > 0 ? .degrees(0 - Double(xPosition) / 15) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .right ? 1 : 3)
        }
    }
    
    @ViewBuilder
    internal func rightContent(_ proxy: GeometryProxy) -> some View {
        switch style {
        case .slide:
            stackContent(rightDataElement)
                .offset(x: xPosition < 0 ? 15 - xPosition : 15, y: 0)
                .scaleEffect(xPosition < 0 ? 0.95 + (-xPosition / proxy.midXPercentage * 0.01) : 0.95)
                .zIndex(direction == .left ? 1 : 3)
        case .rotateIn:
            stackContent(rightDataElement)
                .offset(x: xPosition < 0 ? 15 - xPosition : 15, y: 0)
                .scaleEffect(xPosition < 0 ? 1 : 0.95)
                .rotation3DEffect(
                    xPosition < 0 ? .degrees(0 + Double(xPosition) / 15) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .left ? 1 : 3)
        case .rotateOut:
            stackContent(rightDataElement)
                .offset(x: xPosition < 0 ? 15 - xPosition : 15, y: 0)
                .scaleEffect(xPosition < 0 ? 1 : 0.95)
                .rotation3DEffect(
                    xPosition < 0 ? .degrees(0 - Double(xPosition) / 15) : .zero,
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .zIndex(direction == .left ? 1 : 3)
        }
    }
    
    @ViewBuilder
    internal func mainContent(_ proxy: GeometryProxy) -> some View {
        switch style {
        case .slide:
            stackContent(data[index])
                .zIndex(4)
                .offset(x: xPosition, y: 0)
                .gesture(dragGesture(proxy))
        case .rotateIn:
            stackContent(data[index])
                .zIndex(4)
                .offset(x: xPosition, y: 0)
                .rotation3DEffect(
                    .degrees(0 + Double(-xPosition) / 15),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .gesture(dragGesture(proxy))
        case .rotateOut:
            stackContent(data[index])
                .zIndex(4)
                .offset(x: xPosition, y: 0)
                .rotation3DEffect(
                    .degrees(0 - Double(-xPosition) / 15),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .gesture(dragGesture(proxy))
        }
    }
}

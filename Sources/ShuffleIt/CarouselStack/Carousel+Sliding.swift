import SwiftUI

extension CarouselStack {
    internal func performRestoring() {
        let maxSwipeDistance = size.width * 0.5
        if xPosition > 0 {
            if xPosition >= maxSwipeDistance, let newIndex = data.previousIndex(index, offset: 1) {
                xPosition = xPosition - size.width - spacing
                index = newIndex
                direction = .right
                withAnimation(.easeOut(duration: duration(0.2))) {
                    xPosition = 0
                }
            } else {
                withAnimation(.easeIn(duration: duration(0.15))) {
                    xPosition = 0
                }
            }
        } else if xPosition < 0 {
            if xPosition <= -maxSwipeDistance, let newIndex = data.nextIndex(index, offset: 1) {
                xPosition = xPosition + size.width + spacing
                index = newIndex
                direction = .left
                withAnimation(.easeOut(duration: duration(0.2))) {
                    xPosition = 0
                }
            } else {
                withAnimation(.easeIn(duration: duration(0.15))) {
                    xPosition = 0
                }
            }
        }
    }
    
    private func duration(_ fraction: CGFloat) -> CGFloat {
        let ratio = abs(xPosition / size.width)
        return ratio * fraction + derivativeOf(fn: { $0 * fraction }, atX: ratio)
    }
    
    func derivativeOf(fn: (CGFloat) -> CGFloat, atX x: CGFloat) -> CGFloat {
        let h = 0.0000001
        return (fn(x + h) - fn(x)) / h
    }
}

import SwiftUI

extension CarouselStack {
    internal func performSliding(_ direction: CarouselDirection) {
        self.autoSliding = true
        self.direction = direction
        performMovingToMiddle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.performRestoring()
        }
    }
    
    internal func performMovingToMiddle() {
        let maXSwipeDistance = size.width * 0.5
        withAnimation(animation.timing(duration: 0.1)) {
            switch direction {
            case .left:
                xPosition = maXSwipeDistance
            case .right:
                xPosition = -maXSwipeDistance
            }
        }
    }
    
    
    internal func performRestoring() {
        let maxSwipeDistance = size.width * 0.5
        if xPosition > 0 {
            if xPosition >= maxSwipeDistance, let newIndex = data.previousIndex(index, offset: 1) {
                xPosition = xPosition - size.width - spacing
                let context = CarouselContext(
                    index: data.distance(from: data.startIndex, to: newIndex),
                    previousIndex: data.distance(from: data.startIndex, to: index),
                    direction: .left
                )
                index = newIndex
                direction = .right
                notifyListener(context: context)
                withAnimation(animation.timing(duration: duration(0.2))) {
                    xPosition = 0
                    autoSliding = false
                }
            } else {
                withAnimation(animation.timing(duration: duration(0.15))) {
                    xPosition = 0
                }
            }
        } else if xPosition < 0 {
            if xPosition <= -maxSwipeDistance, let newIndex = data.nextIndex(index, offset: 1) {
                xPosition = xPosition + size.width + spacing
                let context = CarouselContext(
                    index: data.distance(from: data.startIndex, to: newIndex),
                    previousIndex: data.distance(from: data.startIndex, to: index),
                    direction: .right
                )
                index = newIndex
                direction = .left
                notifyListener(context: context)
                withAnimation(animation.timing(duration: duration(0.2))) {
                    xPosition = 0
                    autoSliding = false
                }
            } else {
                withAnimation(animation.timing(duration: duration(0.15))) {
                    xPosition = 0
                }
            }
        }
    }
    
    private func duration(_ fraction: CGFloat) -> CGFloat {
        let ratio = abs(xPosition / size.width)
        return ratio * fraction + derivativeOf(fn: { $0 * fraction }, atX: ratio)
    }
    
    private func derivativeOf(fn: (CGFloat) -> CGFloat, atX x: CGFloat) -> CGFloat {
        let h = 0.0000001
        return (fn(x + h) - fn(x)) / h
    }
    
    private func notifyListener(context: CarouselContext) {
        carouselContext?(context)
    }
    
    internal var translation: CGFloat {
        if size.width > 0 {
            let width = (size.width + spacing) * 0.5
            let position = abs(xPosition).truncatingRemainder(dividingBy: width)
            if abs(xPosition) > width {
                return 1 - (position / width)
            } else {
                return position / width
            }
        }
        return 0
    }
}

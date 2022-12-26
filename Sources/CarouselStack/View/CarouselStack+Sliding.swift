import SwiftUI

extension CarouselStack {
    /// A method that mimics sliding behaviour for the purpose of programmatic sliding.
    internal func performSliding(_ direction: CarouselDirection) {
        self.autoSliding = true
        self.direction = direction
        performMovingToMiddle()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration(0.16)) {
            self.performRestoring()
        }
    }
    
    /// A method that mimics sliding behaviour to slide view to left or right for the purpose of programmatic sliding.
    internal func performMovingToMiddle() {
        let maXSwipeDistance = size.width * 0.6
        withAnimation(animation.timing(duration: duration(0.15))) {
            switch direction {
            case .left:
                xPosition = maXSwipeDistance
            case .right:
                xPosition = -maXSwipeDistance
            }
        }
    }
    
    /// A method that performs to restore content views, which have already been in the middle of sliding in the process of sliding, to the original position.
    internal func performRestoring() {
        let maxSwipeDistance = size.width * 0.5
        if xPosition > 0 {
            let newIndex: Data.Index?
            switch style {
            case .infiniteScroll:
                newIndex = data.previousIndex(forLoop: index, offset: 1)
            case .finiteScroll:
                newIndex = data.previousIndex(forUnloop: index, offset: 1)
            }
            if xPosition >= maxSwipeDistance, let newIndex = newIndex {
                xPosition = xPosition - size.width - spacing
                let context = CarouselContext(
                    index: data.distance(from: data.startIndex, to: newIndex),
                    previousIndex: data.distance(from: data.startIndex, to: index),
                    direction: .left
                )
                index = newIndex
                direction = .right
                notifyListener(context: context)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation(animation.timing(duration: duration(0.12))) {
                        xPosition = 0
                        autoSliding = false
                    }
                }
            } else {
                withAnimation(animation.timing(duration: duration(0.15))) {
                    xPosition = 0
                }
            }
        } else if xPosition < 0 {
            let newIndex: Data.Index?
            switch style {
            case .infiniteScroll:
                newIndex = data.nextIndex(forLoop: index, offset: 1)
            case .finiteScroll:
                newIndex = data.nextIndex(forUnloop: index, offset: 1)
            }
            if xPosition <= -maxSwipeDistance, let newIndex = newIndex {
                xPosition = xPosition + size.width + spacing
                let context = CarouselContext(
                    index: data.distance(from: data.startIndex, to: newIndex),
                    previousIndex: data.distance(from: data.startIndex, to: index),
                    direction: .right
                )
                index = newIndex
                direction = .left
                notifyListener(context: context)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation(animation.timing(duration: duration(0.12))) {
                        xPosition = 0
                        autoSliding = false
                    }
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
    
    /// A method that notifies an listener with context value after sliding succeeds.
    private func notifyListener(context: CarouselContext) {
        carouselContext?(context)
    }
    
    /// A property that calculates translation value of swiping content views.
    internal var translation: CGFloat {
        if size.width > 0 {
            let width = (size.width + spacing * 2) / 2
            let position = abs(xPosition).truncatingRemainder(dividingBy: width)
            if abs(xPosition) > width {
                return 1 - (position / width)
            } else {
                return position / width
            }
        }
        return 0
    }
    
    /// A property that calculates scaleFactor for the views based on their position.
    internal var scaleFactor: CGFloat {
        if size.width > 0 {
            let width = (size.width + spacing * 2)
            return min(1, abs(xPosition) / width)
        }
        return 0
    }
}

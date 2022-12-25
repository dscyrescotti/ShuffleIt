import Utils
import SwiftUI

extension ShuffleDeck {
    /// A method that mimics shuffling behavoir for the purpose of programmatic shuffling.
    internal func performShuffling(_ direction: ShuffleDeckDirection) {
        self.autoShuffling = true
        self.direction = direction
        performSpreadingOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.performRestoring()
        }
    }

    /// A method that mimics shuffling behaviour of dragging view to left or right for the purpose of programmatic shuffling.
    internal func performSpreadingOut() {
        let maxSwipeDistance = size.width * 0.25
        withAnimation(animation.timing(duration: 0.08)) {
            switch direction {
            case .left:
                xPosition = maxSwipeDistance
            case .right:
                xPosition = -maxSwipeDistance
            }
        }
    }

    /// A method that performs to restore content views, which have already spread out in the process of shuffling, to the original position.
    internal func performRestoring() {
        let midX = size.width * 0.5
        let maxSwipeDistance = size.width * 0.25
        if xPosition > 0 {
            let newIndex: Data.Index?
            switch style {
            case .infiniteShuffle:
                newIndex = data.previousIndex(forLoop: index, offset: 1)
            case .finiteShuffle:
                newIndex = data.previousIndex(forUnloop: index, offset: 1)
            }
            if xPosition >= maxSwipeDistance, let nextIndex = newIndex {
                withAnimation(animation.timing(duration: 0.08)) {
                    xPosition = midX + midX * 0.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(animation.timing(duration: 0.03)) {
                        isShiftedRight = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let context = ShuffleDeckContext(
                        index: data.distance(from: data.startIndex, to: nextIndex),
                        previousIndex: data.distance(from: data.startIndex, to: index),
                        direction: .left
                    )
                    notifyListener(context: context)
                    withAnimation(animation.timing(duration: 0.08)) {
                        isLockedLeft = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    index = nextIndex
                    isShiftedRight = false
                    isLockedLeft = false
                    xPosition = 0
                    autoShuffling = false
                }
            } else {
                withAnimation(animation.timing(duration: 0.1)) {
                    xPosition = 0
                }
            }
        } else if xPosition < 0 {
            let newIndex: Data.Index?
            switch style {
            case .infiniteShuffle:
                newIndex = data.nextIndex(forLoop: index, offset: 1)
            case .finiteShuffle:
                newIndex = data.nextIndex(forUnloop: index, offset: 1)
            }
            if xPosition <= -maxSwipeDistance, let nextIndex = newIndex {
                withAnimation(animation.timing(duration: 0.08)) {
                    xPosition = -midX - midX * 0.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(animation.timing(duration: 0.03)) {
                        isShiftedLeft = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let context = ShuffleDeckContext(
                        index: data.distance(from: data.startIndex, to: nextIndex),
                        previousIndex: data.distance(from: data.startIndex, to: index),
                        direction: .right
                    )
                    notifyListener(context: context)
                    withAnimation(animation.timing(duration: 0.08)) {
                        isLockedRight = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    index = nextIndex
                    isShiftedLeft = false
                    isLockedRight = false
                    xPosition = 0
                    autoShuffling = false
                }
            } else {
                withAnimation(animation.timing(duration: 0.1)) {
                    xPosition = 0
                }
            }
        }
    }

    /// A method that notifies an listener with context value after shuffling succeeds.
    private func notifyListener(context: ShuffleDeckContext) {
        shuffleDeckContext?(context)
    }

    /// A property that calculates translation value of dragging content views.
    internal var translation: CGFloat {
        return size.width > 0 ? min(abs(xPosition) / (size.width * 0.5), 1) : 0
    }

    /// A property that calculates drag amount of the content view.
    internal var factor: CGFloat {
        return size.width > 0 ? xPosition / (size.width * 0.5) : 0
    }
}

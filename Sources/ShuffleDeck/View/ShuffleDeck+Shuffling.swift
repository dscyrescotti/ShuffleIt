import Utils
import SwiftUI

extension ShuffleDeck {
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
                withAnimation(animation.timing(duration: 0.1)) {
                    xPosition = midX + midX * 0.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
                    #warning("TODO: notify listener")
                    withAnimation(animation.timing(duration: 0.1)) {
                        isLockedLeft = true
                    }
                    withAnimation(animation.timing(duration: 0.02)) {
                        isShiftedRight = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.23) {
                    index = nextIndex
                    isShiftedRight = false
                    isLockedLeft = false
                    xPosition = 0
                }
            } else {
                withAnimation(animation.timing(duration: 0.15)) {
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
                withAnimation(animation.timing(duration: 0.1)) {
                    xPosition = -midX - midX * 0.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
                    #warning("TODO: notify listener")
                    withAnimation(animation.timing(duration: 0.1)) {
                        isLockedRight = true
                    }
                    withAnimation(animation.timing(duration: 0.02)) {
                        isShiftedLeft = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.23) {
                    index = nextIndex
                    isShiftedLeft = false
                    isLockedRight = false
                    xPosition = 0
                }
            } else {
                withAnimation(animation.timing(duration: 0.15)) {
                    xPosition = 0
                }
            }
        }
    }

    internal var translation: CGFloat {
        return size.width > 0 ? max(0, min(xPosition / (size.width * 0.5), 1)) : 0
    }

    internal var factor: CGFloat {
        return size.width > 0 ? xPosition / (size.width * 0.5) : 0
    }
}

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
                withAnimation(animation.timing(duration: 0.03)) {
                    xPosition = midX + midX * 0.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
                    print(xPosition, translation, midX, direction)

                    #warning("TODO: notify listener")
                    withAnimation(animation.timing(duration: 0.05)) {
                        isLockedLeft = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                    index = nextIndex
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
//                if xPosition > -midX {
//                    withAnimation(animation.timing(duration: 0.15)) {
//                        xPosition = -midX
//                    }
//                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    index = nextIndex
                    direction = .left
                    isLockedRight = true
                    #warning("TODO: notify listener")
                    withAnimation(animation.timing(duration: 0.2)) {
                        xPosition = 0
                        isLockedRight = false
                    }
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

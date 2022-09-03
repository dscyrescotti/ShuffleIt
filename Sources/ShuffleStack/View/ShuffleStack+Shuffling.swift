import SwiftUI

extension ShuffleStack {
    internal func performShuffling(_ direction: Direction) {
        self.autoShuffling = true
        self.direction = direction
        performSpreadingOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.performRestoring()
        }
    }
    
    internal func performSpreadingOut() {
        let maxSwipeDistance = size.width * 0.25
        withAnimation(animation.timing(duration: 0.1)) {
            switch direction {
            case .left:
                xPosition = maxSwipeDistance
            case .right:
                xPosition = -maxSwipeDistance
            }
        }
    }
    
    internal func performRestoring() {
        let midX = size.width * 0.5
        let maxSwipeDistance = size.width * 0.25
        if xPosition > 0 {
            if xPosition < maxSwipeDistance {
                withAnimation(animation.timing(duration: 0.15)) {
                    xPosition = 0
                }
            } else {
                withAnimation(animation.timing(duration: 0.15)) {
                    xPosition = midX
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    xPosition = -xPosition
                    index = data.previousIndex(index, offset: 1)
                    direction = .right
                    isLockedLeft = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(animation.timing(duration: 0.2)) {
                        xPosition = 0
                        isLockedLeft = false
                        autoShuffling = false
                    }
                }
            }
        } else if xPosition < 0 {
            if xPosition > -maxSwipeDistance {
                withAnimation(animation.timing(duration: 0.15)) {
                    xPosition = 0
                }
            } else {
                withAnimation(animation.timing(duration: 0.15)) {
                    xPosition = -midX
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    xPosition = -xPosition
                    index = data.nextIndex(index, offset: 1)
                    direction = .left
                    isLockedRight = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(animation.timing(duration: 0.2)) {
                        xPosition = 0
                        isLockedRight = false
                        autoShuffling = false
                    }
                }
                
            }
        }
    }
}

import SwiftUI

// MARK: - Gesture
extension ShuffleStack {
    internal var dragGesture: some Gesture {
        DragGesture()
            .onChanged({ value in
                xPosition = value.translation.width / 2.3
                if xPosition > 0 {
                    direction = .left
                } else if xPosition < 0 {
                    direction = .right
                }
            })
            .onEnded({ value in
                let midX = size.width * 0.5
                let maxSwipeDistance = size.width * 0.25
                if xPosition > 0 {
                    if xPosition < maxSwipeDistance {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = 0
                        }
                    } else {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = midX
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            xPosition = -xPosition
                            index = data.previousIndex(index, offset: 1)
                            direction = .right
                            isLockedLeft = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.linear(duration: 0.2)) {
                                xPosition = 0
                                isLockedLeft = false
                            }
                        }
                    }
                } else if xPosition < 0 {
                    if xPosition > -maxSwipeDistance {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = 0
                        }
                    } else {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = -midX
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            xPosition = -xPosition
                            index = data.nextIndex(index, offset: 1)
                            direction = .left
                            isLockedRight = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.linear(duration: 0.2)) {
                                xPosition = 0
                                isLockedRight = false
                            }
                        }
                        
                    }
                }
            })
    }
}

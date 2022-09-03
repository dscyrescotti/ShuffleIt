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
                performRestoring()
            })
    }
}

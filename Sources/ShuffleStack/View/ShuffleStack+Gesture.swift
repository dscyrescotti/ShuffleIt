import SwiftUI

// MARK: - Gesture
extension ShuffleStack {
    internal var dragGesture: some Gesture {
        DragGesture()
            .updating($isActiveGesture, body: { _, state, _ in
                state = true
            })
            .onChanged({ value in
                xPosition = value.translation.width / 2.3
                if xPosition > 0 {
                    direction = .left
                } else if xPosition < 0 {
                    direction = .right
                }
            })
    }
}

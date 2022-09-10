import SwiftUI

extension ShuffleStack {
    /// A drag gesture that listens gesture state on content views and calculates rotation and position for shuffling.
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
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

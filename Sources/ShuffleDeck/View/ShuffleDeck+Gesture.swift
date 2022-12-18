import SwiftUI

extension ShuffleDeck {
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    internal var dragGesture: some Gesture {
        DragGesture()
            .updating($isActiveGesture) { _, state, _ in
                state = true
            }
            .onChanged { value in
                let position = value.translation.width / 1.2
                let range = size.width * 0.4
                xPosition = min(max(position, -range), range)
                if xPosition > 0 {
                    direction = .left
                } else if xPosition < 0 {
                    direction = .right
                }
            }
    }
}

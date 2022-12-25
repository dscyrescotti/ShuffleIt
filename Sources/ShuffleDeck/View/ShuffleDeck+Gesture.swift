import SwiftUI

extension ShuffleDeck {
    /// A drag gesture that listens gesture state on content views and calculates rotation and position for shuffling.
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    internal var dragGesture: some Gesture {
        DragGesture()
            .updating($isActiveGesture) { _, state, _ in
                state = true
            }
            .onChanged { value in
                var position: CGFloat
                switch style {
                case .infiniteShuffle:
                    position = value.translation.width / 1.2
                case .finiteShuffle:
                    position = value.translation.width / 1.2
                    if position > 0, data.previousIndex(forUnloop: index, offset: 1) == nil {
                        position /= 15
                    }
                    if position < 0, data.nextIndex(forUnloop: index, offset: 1) == nil {
                        position /= 15
                    }
                }
                let range = size.width * 0.5
                xPosition = min(max(position, -range), range)
                if xPosition > 0 {
                    direction = .left
                } else if xPosition < 0 {
                    direction = .right
                }
            }
    }
}

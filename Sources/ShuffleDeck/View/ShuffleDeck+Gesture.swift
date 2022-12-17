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
                let position = value.translation.width / 1.2 - (data.distance(from: data.startIndex, to: data.endIndex) == 1 ? value.translation.width * 0.2 : 0)
                let range = size.width * 0.5
                xPosition = min(max(position, -range), range)
                if xPosition > 0 {
                    direction = .left
                } else if xPosition < 0 {
                    direction = .right
                }
//                print(xPosition, direction, translation)
            }
    }
}

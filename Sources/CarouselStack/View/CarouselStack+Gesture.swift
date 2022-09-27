import SwiftUI

extension CarouselStack {
    /// A drag gesture that listens gesture state on content views and calculates rotation and position for shuffling.
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    internal var dragGesture: some Gesture {
        DragGesture()
            .updating($isActiveGesture, body: { _, state, _ in
                state = true
            })
            .onChanged({ value in
                let translation = value.translation.width
                if translation > 0 {
                    switch style {
                    case .infiniteScroll:
                        xPosition = translation
                    case .finiteScroll:
                        xPosition = translation - (index == data.startIndex ? translation * 0.7 : 0)
                    }
                    direction = .left
                } else if translation < 0 {
                    switch style {
                    case .infiniteScroll:
                        xPosition = translation
                    case .finiteScroll:
                        xPosition = translation - (index == data.index(before: data.endIndex) ? translation * 0.7 : 0)
                    }
                    direction = .right
                }
            })
    }
}

import SwiftUI

struct ShuffleStackSwipeDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var swipeDisabled: Bool {
        get { self[ShuffleStackSwipeDisabledKey.self] }
        set { self[ShuffleStackSwipeDisabledKey.self] = newValue }
    }
}

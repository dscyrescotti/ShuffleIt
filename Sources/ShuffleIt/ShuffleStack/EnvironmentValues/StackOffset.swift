import SwiftUI

/// An environment key for stack offset.
struct StackOffsetKey: EnvironmentKey {
    static var defaultValue: CGFloat = 15
}

extension EnvironmentValues {
    var stackOffset: CGFloat {
        get { self[StackOffsetKey.self] }
        set { self[StackOffsetKey.self] = max(newValue, 0) }
    }
}

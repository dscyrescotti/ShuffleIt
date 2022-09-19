import Utils
import SwiftUI

/// An environment key for shuffle stack offset.
struct ShuffleOffsetKey: EnvironmentKey {
    static var defaultValue: CGFloat = 15
}

extension EnvironmentValues {
    var shuffleOffset: CGFloat {
        get { self[ShuffleOffsetKey.self] }
        set { self[ShuffleOffsetKey.self] = max(newValue, 0) }
    }
}

import SwiftUI

/// An environment key for shuffle stack scale.
struct ShuffleScaleKey: EnvironmentKey {
    static var defaultValue: CGFloat = 0.95
}

extension EnvironmentValues {
    var shuffleScale: CGFloat {
        get { self[ShuffleScaleKey.self] }
        set { self[ShuffleScaleKey.self] = (min(1, max(0, newValue)) * 0.1) + 0.9 }
    }
}

import SwiftUI

/// An environment key for shuffle stack padding.
struct ShufflePaddingKey: EnvironmentKey {
    static var defaultValue: CGFloat = 15
}

extension EnvironmentValues {
    var shufflePadding: CGFloat {
        get { self[ShufflePaddingKey.self] }
        set { self[ShufflePaddingKey.self] = newValue }
    }
}

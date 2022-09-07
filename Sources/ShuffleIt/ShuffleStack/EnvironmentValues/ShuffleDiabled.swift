import SwiftUI

/// An environment key for a flag to decide on whether shuffling is disable or not.
struct ShuffleDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var shuffleDisabled: Bool {
        get { self[ShuffleDisabledKey.self] }
        set { self[ShuffleDisabledKey.self] = newValue }
    }
}

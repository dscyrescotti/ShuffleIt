import SwiftUI

/// An environment key for a flag to decide on whether shuffling is disable or not.
@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
@available(tvOS, unavailable)
struct ShuffleDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    var shuffleDisabled: Bool {
        get { self[ShuffleDisabledKey.self] }
        set { self[ShuffleDisabledKey.self] = newValue }
    }
}

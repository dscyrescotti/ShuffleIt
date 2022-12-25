import SwiftUI

/// An environent key for a flag to decide on whether shuffling is disabled or not.
@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
@available(tvOS, unavailable)
struct ShuffleDeckDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    var shuffleDeckDisabled: Bool {
        get { self[ShuffleDeckDisabledKey.self] }
        set { self[ShuffleDeckDisabledKey.self] = newValue }
    }
}

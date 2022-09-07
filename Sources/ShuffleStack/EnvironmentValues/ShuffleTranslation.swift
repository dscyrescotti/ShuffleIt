import SwiftUI

/// An environment key for suffle translation.
struct ShuffleTranslation: EnvironmentKey {
    static var defaultValue: ((CGFloat) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleTranslation: ((CGFloat) -> Void)? {
        get { self[ShuffleTranslation.self] }
        set { self[ShuffleTranslation.self] = newValue }
    }
}

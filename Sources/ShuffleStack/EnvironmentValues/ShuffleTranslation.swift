import SwiftUI

/// An environment key for suffle translation.
struct ShuffleTranslationKey: EnvironmentKey {
    static var defaultValue: ((CGFloat) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleTranslation: ((CGFloat) -> Void)? {
        get { self[ShuffleTranslationKey.self] }
        set { self[ShuffleTranslationKey.self] = newValue }
    }
}

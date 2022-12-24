import SwiftUI

struct ShuffleDeckTranslationKey: EnvironmentKey {
    static var defaultValue: ((CGFloat) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleDeckTranslation: ((CGFloat) -> Void)? {
        get { self[ShuffleDeckTranslationKey.self] }
        set { self[ShuffleDeckTranslationKey.self] = newValue }
    }
}

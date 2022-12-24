import SwiftUI

/// An environment key for carousel translation.
struct CarouselTranslationKey: EnvironmentKey {
    static var defaultValue: ((CGFloat) -> Void)? = nil
}

extension EnvironmentValues {
    var carouselTranslation: ((CGFloat) -> Void)? {
        get { self[CarouselTranslationKey.self] }
        set { self[CarouselTranslationKey.self] = newValue }
    }
}


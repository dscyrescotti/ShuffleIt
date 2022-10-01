import SwiftUI

/// An environment key for suffle translation.
struct CarouselTranslation: EnvironmentKey {
    static var defaultValue: ((CGFloat) -> Void)? = nil
}

extension EnvironmentValues {
    var carouselTranslation: ((CGFloat) -> Void)? {
        get { self[CarouselTranslation.self] }
        set { self[CarouselTranslation.self] = newValue }
    }
}


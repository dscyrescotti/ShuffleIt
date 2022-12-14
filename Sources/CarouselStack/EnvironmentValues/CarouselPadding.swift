import SwiftUI

/// An environment key for carousel padding.
struct CarouselPaddingKey: EnvironmentKey {
    static var defaultValue: CGFloat = 20
}

extension EnvironmentValues {
    var carouselPadding: CGFloat {
        get { self[CarouselPaddingKey.self] }
        set { self[CarouselPaddingKey.self] = newValue }
    }
}

import SwiftUI

/// An environment key for carousel spacing.
struct CarouselSpacingKey: EnvironmentKey {
    static var defaultValue: CGFloat = 10
}

extension EnvironmentValues {
    var carouselSpacing: CGFloat {
        get { self[CarouselSpacingKey.self] }
        set { self[CarouselSpacingKey.self] = newValue }
    }
}

import SwiftUI

/// An environment key for carousel scale.
struct CarouselScaleKey: EnvironmentKey {
    static let defaultValue: CGFloat = 1
}

extension EnvironmentValues {
    var carouselScale: CGFloat {
        get { self[CarouselScaleKey.self] }
        set { self[CarouselScaleKey.self] = newValue }
    }
}

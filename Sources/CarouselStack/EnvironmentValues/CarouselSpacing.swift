import SwiftUI

struct CarouselSpacingKey: EnvironmentKey {
    static var defaultValue: CGFloat = 10
}

extension EnvironmentValues {
    var carouselSpacing: CGFloat {
        get { self[CarouselSpacingKey.self] }
        set { self[CarouselSpacingKey.self] = newValue }
    }
}

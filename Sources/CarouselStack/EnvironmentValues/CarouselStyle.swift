import SwiftUI

public enum CarouselStyle {
    case infiniteScroll
    case finiteScroll
}

struct CarouselStyleKey: EnvironmentKey {
    static var defaultValue: CarouselStyle = .finiteScroll
}

extension EnvironmentValues {
    var carouselStyle: CarouselStyle {
        get { self[CarouselStyleKey.self] }
        set { self[CarouselStyleKey.self] = newValue }
    }
}

import SwiftUI

/// An environment key for a flag to decide on whether sliding is disabled or not.
@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
@available(tvOS, unavailable)
struct CarouselDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    var carouselDisabled: Bool {
        get { self[CarouselDisabledKey.self] }
        set { self[CarouselDisabledKey.self] = newValue }
    }
}

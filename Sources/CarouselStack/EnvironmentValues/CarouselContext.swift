import SwiftUI

/// A structure that provides information about sliding.
public struct CarouselContext {
    /// A property of current index of carousel stack view.
    public let index: Int
    /// A property of pervious index of carousel stack view.
    public let previousIndex: Int
    /// A property of carousel direction to which content view was slided.
    public let direction: CarouselDirection
}

/// An environment key for carousel context.
struct CarouselContextKey: EnvironmentKey {
    static var defaultValue: ((CarouselContext) -> Void)? = nil
}

extension EnvironmentValues {
    var carouselContext: ((CarouselContext) -> Void)? {
        get { self[CarouselContextKey.self] }
        set { self[CarouselContextKey.self] = newValue }
    }
}


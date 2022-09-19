import SwiftUI

public struct CarouselContext {
    public let index: Int
    public let previousIndex: Int
    public let direction: CarouselDirection
}

struct CarouselContextKey: EnvironmentKey {
    static var defaultValue: ((CarouselContext) -> Void)? = nil
}

extension EnvironmentValues {
    var carouselContext: ((CarouselContext) -> Void)? {
        get { self[CarouselContextKey.self] }
        set { self[CarouselContextKey.self] = newValue }
    }
}


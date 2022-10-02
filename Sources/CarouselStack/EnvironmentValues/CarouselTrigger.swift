import SwiftUI
import Combine

/// An enumeratoin of carousel direction.
public enum CarouselDirection {
    /// A slide direction to the left.
    case left
    /// A slide direction to the right.
    case right
}

/// An environment key for carousel trigger.
struct CarouselTriggerKey: EnvironmentKey {
    static var defaultValue: AnyPublisher<CarouselDirection, Never> = Empty<CarouselDirection, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var carouselTrigger: AnyPublisher<CarouselDirection, Never> {
        get { self[CarouselTriggerKey.self] }
        set { self[CarouselTriggerKey.self] = newValue }
    }
}

import SwiftUI
import Combine

public enum CarouselDirection {
    case left
    case right
}

struct CarouselTriggerKey: EnvironmentKey {
    static var defaultValue: AnyPublisher<CarouselDirection, Never> = Empty<CarouselDirection, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var carouselTrigger: AnyPublisher<CarouselDirection, Never> {
        get { self[CarouselTriggerKey.self] }
        set { self[CarouselTriggerKey.self] = newValue }
    }
}

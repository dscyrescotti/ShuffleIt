import SwiftUI
import Combine

/// An enumeration of shuffle deck direction.
public enum ShuffleDeckDirection {
    /// A shuffle direction to the left.
    case left
    /// A shuffle direction to the right.
    case right
}

/// An environment key for shuffle deck trigger.
struct ShuffleDeckTriggerKey: EnvironmentKey {
    static var defaultValue: AnyPublisher<ShuffleDeckDirection, Never> = Empty<ShuffleDeckDirection, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var shuffleDeckTrigger: AnyPublisher<ShuffleDeckDirection, Never> {
        get { self[ShuffleDeckTriggerKey.self] }
        set { self[ShuffleDeckTriggerKey.self] = newValue }
    }
}

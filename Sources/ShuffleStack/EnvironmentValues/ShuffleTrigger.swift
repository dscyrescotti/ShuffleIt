import SwiftUI
import Combine

/// An enumeration of shuffle direction.
public enum ShuffleDirection {
    /// A shuffle direction to the left.
    case left
    /// A shuffle direction to the right.
    case right
}

struct ShuffleTriggerKey: EnvironmentKey {
    static var defaultValue: AnyPublisher<ShuffleDirection, Never> = Empty<ShuffleDirection, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var shuffleTrigger: AnyPublisher<ShuffleDirection, Never> {
        get { self[ShuffleTriggerKey.self] }
        set { self[ShuffleTriggerKey.self] = newValue }
    }
}

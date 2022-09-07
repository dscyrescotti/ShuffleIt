import SwiftUI
import Combine

/// An enumeration of shuffle direction.
public enum Direction {
    /// A shuffle direction to the left.
    case left
    /// A shuffle direction to the right.
    case right
}

struct ShuffleTriggerKey: EnvironmentKey {
    static var defaultValue: AnyPublisher<Direction, Never> = Empty<Direction, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var shuffleTrigger: AnyPublisher<Direction, Never> {
        get { self[ShuffleTriggerKey.self] }
        set { self[ShuffleTriggerKey.self] = newValue }
    }
}

import SwiftUI
import Combine

public enum Direction {
    case left
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

import SwiftUI
import Combine

public enum Direction {
    case left
    case right
}

struct ShuffleStackShufflingPublisher: EnvironmentKey {
    static var defaultValue: AnyPublisher<Direction, Never> = Empty<Direction, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var shufflingPublisher: AnyPublisher<Direction, Never> {
        get { self[ShuffleStackShufflingPublisher.self] }
        set { self[ShuffleStackShufflingPublisher.self] = newValue }
    }
}

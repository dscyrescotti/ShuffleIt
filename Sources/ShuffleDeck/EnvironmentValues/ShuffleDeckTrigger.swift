import SwiftUI
import Combine

public enum ShuffleDeckDirection {
    case left
    case right
}

struct ShuffleDeckTriggerKey: EnvironmentKey {
    static var defaultValue: AnyPublisher<ShuffleDeckDirection, Never> = Empty<ShuffleDeckDirection, Never>().eraseToAnyPublisher()
}

extension EnvironmentValues {
    var shuffleDeckTrigger: AnyPublisher<ShuffleDeckDirection, Never> {
        get { self[ShuffleDeckTriggerKey.self] }
        set { self[ShuffleDeckTriggerKey.self] = newValue }
    }
}

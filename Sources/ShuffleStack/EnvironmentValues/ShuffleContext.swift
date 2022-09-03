import SwiftUI

public struct ShuffleContext {
    public let index: Int
    public let previousIndex: Int
    public let direction: Direction
}

struct ShuffleContextKey: EnvironmentKey {
    static var defaultValue: ((ShuffleContext) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleContext: ((ShuffleContext) -> Void)? {
        get { self[ShuffleContextKey.self] }
        set { self[ShuffleContextKey.self] = newValue }
    }
}

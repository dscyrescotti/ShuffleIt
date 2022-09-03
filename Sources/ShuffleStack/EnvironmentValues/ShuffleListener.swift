import SwiftUI

public struct ShuffleContext {
    public let index: Int
    public let previousIndex: Int
    public let direction: Direction
}

struct ShuffleListener: EnvironmentKey {
    static var defaultValue: ((ShuffleContext) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleListener: ((ShuffleContext) -> Void)? {
        get { self[ShuffleListener.self] }
        set { self[ShuffleListener.self] = newValue }
    }
}

import SwiftUI

public struct ShuffleDeckContext {
    public let index: Int
    public let previousIndex: Int
    public let direction: ShuffleDeckDirection
}

struct ShuffleDeckContextKey: EnvironmentKey {
    static var defaultValue: ((ShuffleDeckContext) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleDeckContext: ((ShuffleDeckContext) -> Void)? {
        get { self[ShuffleDeckContextKey.self] }
        set { self[ShuffleDeckContextKey.self] = newValue }
    }
}

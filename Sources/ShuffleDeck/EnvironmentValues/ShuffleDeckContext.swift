import SwiftUI

/// A structure that provides information about shuffling.
public struct ShuffleDeckContext {
    /// A property of current index of shuffle deck view.
    public let index: Int
    /// A property of previous index of shuffle deck view.
    public let previousIndex: Int
    /// A property of shuffle deck direction to which content view was dragged.
    public let direction: ShuffleDeckDirection
}

/// An environment key for shuffle deck context.
struct ShuffleDeckContextKey: EnvironmentKey {
    static var defaultValue: ((ShuffleDeckContext) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleDeckContext: ((ShuffleDeckContext) -> Void)? {
        get { self[ShuffleDeckContextKey.self] }
        set { self[ShuffleDeckContextKey.self] = newValue }
    }
}

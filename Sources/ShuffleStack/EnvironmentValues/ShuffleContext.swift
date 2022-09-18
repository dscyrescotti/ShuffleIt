import SwiftUI

/// A structure that provides information about shuffling.
public struct ShuffleContext {
    /// A property of current index of shuffle stack view.
    public let index: Int
    /// A property of previous index of shuffle stack view.
    public let previousIndex: Int
    /// A property of shuffling direction to which content view was swiped.
    public let direction: ShuffleDirection
}

/// An environment key for shuffle context.
struct ShuffleContextKey: EnvironmentKey {
    static var defaultValue: ((ShuffleContext) -> Void)? = nil
}

extension EnvironmentValues {
    var shuffleContext: ((ShuffleContext) -> Void)? {
        get { self[ShuffleContextKey.self] }
        set { self[ShuffleContextKey.self] = newValue }
    }
}

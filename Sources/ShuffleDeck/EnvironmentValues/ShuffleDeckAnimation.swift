import SwiftUI

/// An enumeration of shuffle deck animation that maps to `SwiftUI` animation.
public enum ShuffleDeckAnimation {
    /// A linear animation.
    case linear
    /// An ease-in animation.
    case easeIn
    /// An ease-out animation.
    case easeOut
    /// An ease-in-out animation.
    case easeInOut

    func timing(duration: Double) -> Animation {
        switch self {
        case .linear:
            return .linear(duration: duration)
        case .easeIn:
            return .easeIn(duration: duration)
        case .easeOut:
            return .easeOut(duration: duration)
        case .easeInOut:
            return .easeInOut(duration: duration)
        }
    }
}

/// An environment key for shuffle deck animation.
struct ShuffleDeckAnimationKey: EnvironmentKey {
    static var defaultValue: ShuffleDeckAnimation = .linear
}

extension EnvironmentValues {
    var shuffleDeckAnimation: ShuffleDeckAnimation {
        get { self[ShuffleDeckAnimationKey.self] }
        set { self[ShuffleDeckAnimationKey.self] = newValue }
    }
}

import SwiftUI

/// An enumeration of shuffle animation that maps to `SwiftUI` animation.
public enum ShuffleAnimation {
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

/// An environment key for shuffle animation.
struct ShuffleAnimationKey: EnvironmentKey {
    static var defaultValue: ShuffleAnimation = .linear
}

extension EnvironmentValues {
    var shuffleAnimation: ShuffleAnimation {
        get { self[ShuffleAnimationKey.self] }
        set { self[ShuffleAnimationKey.self] = newValue }
    }
}

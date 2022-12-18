import SwiftUI

public enum ShuffleDeckAnimation {
    case linear
    case easeIn
    case easeOut
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

struct ShuffleDeckAnimationKey: EnvironmentKey {
    static var defaultValue: ShuffleDeckAnimation = .linear
}

extension EnvironmentValues {
    var shuffleDeckAnimation: ShuffleDeckAnimation {
        get { self[ShuffleDeckAnimationKey.self] }
        set { self[ShuffleDeckAnimationKey.self] = newValue }
    }
}

import SwiftUI

public enum ShuffleStackAnimation {
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

struct ShuffleStackAnimationKey: EnvironmentKey {
    static var defaultValue: ShuffleStackAnimation = .linear
}

extension EnvironmentValues {
    var shuffleStackAnimation: ShuffleStackAnimation {
        get { self[ShuffleStackAnimationKey.self] }
        set { self[ShuffleStackAnimationKey.self] = newValue }
    }
}

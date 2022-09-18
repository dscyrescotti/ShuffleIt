import SwiftUI

/// An enumeration of carousel animation that maps to `SwiftUI` animation.
public enum CarouselAnimation {
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

/// An environment key for carousel animation.
struct CarouselAnimationKey: EnvironmentKey {
    static var defaultValue: CarouselAnimation = .linear
}

extension EnvironmentValues {
    var carouselAnimation: CarouselAnimation {
        get { self[CarouselAnimationKey.self] }
        set { self[CarouselAnimationKey.self] = newValue }
    }
}

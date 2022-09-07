import SwiftUI

/// An enumeration of shuffle style that is used to change shuffling behaviour of the shuffle stack view.
public enum ShuffleStyle {
    /// A shuffle style which just slides content views without rotating.
    case slide
    /// A shuffle style which rotates and scales into center while shuffling.
    case rotateIn
    /// A shuffle style which rotates and scales to outside while shuffling.
    case rotateOut
}

/// An environment key for shuffle style.
struct ShuffleStyleKey: EnvironmentKey {
    static var defaultValue: ShuffleStyle = .slide
}

extension EnvironmentValues {
    var shuffleStyle: ShuffleStyle {
        get { self[ShuffleStyleKey.self] }
        set { self[ShuffleStyleKey.self] = newValue }
    }
}

import SwiftUI

/// An enumeration of shuffle deck style that is used to change shuffling behaviour of the shuffle deck view.
public enum ShuffleDeckStyle {
    /// A shuffle deck style which makes content views scroll in the loop without ending.
    case infiniteShuffle
    /// A shuffle deck style which ends content views at both ends so that it cannot be shuffled infinitely.
    case finiteShuffle
}

/// An environment key for shuffle deck style.
struct ShuffleDeckStyleKey: EnvironmentKey {
    static var defaultValue: ShuffleDeckStyle = .finiteShuffle
}

extension EnvironmentValues {
    var shuffleDeckStyle: ShuffleDeckStyle {
        get { self[ShuffleDeckStyleKey.self] }
        set { self[ShuffleDeckStyleKey.self] = newValue }
    }
}

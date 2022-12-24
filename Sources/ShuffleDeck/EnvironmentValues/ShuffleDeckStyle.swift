import SwiftUI

public enum ShuffleDeckStyle {
    case infiniteShuffle
    case finiteShuffle
}

struct ShuffleDeckStyleKey: EnvironmentKey {
    static var defaultValue: ShuffleDeckStyle = .finiteShuffle
}

extension EnvironmentValues {
    var shuffleDeckStyle: ShuffleDeckStyle {
        get { self[ShuffleDeckStyleKey.self] }
        set { self[ShuffleDeckStyleKey.self] = newValue }
    }
}
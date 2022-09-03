import SwiftUI

public enum ShuffleStyle {
    case slide
    case rotateIn
    case rotateOut
}

struct ShuffleStyleKey: EnvironmentKey {
    static var defaultValue: ShuffleStyle = .slide
}

extension EnvironmentValues {
    var shuffleStyle: ShuffleStyle {
        get { self[ShuffleStyleKey.self] }
        set { self[ShuffleStyleKey.self] = newValue }
    }
}

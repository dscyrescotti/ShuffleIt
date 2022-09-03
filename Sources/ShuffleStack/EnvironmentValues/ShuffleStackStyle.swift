import SwiftUI

public enum ShuffleStackStyle {
    case slide
    case rotateIn
    case rotateOut
}

struct ShuffleStackStyleKey: EnvironmentKey {
    static var defaultValue: ShuffleStackStyle = .slide
}

extension EnvironmentValues {
    var shuffleStackStyle: ShuffleStackStyle {
        get { self[ShuffleStackStyleKey.self] }
        set { self[ShuffleStackStyleKey.self] = newValue }
    }
}
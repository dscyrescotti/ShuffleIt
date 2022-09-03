import SwiftUI

struct ShuffleStackOffsetKey: EnvironmentKey {
    static var defaultValue: CGFloat = 15
}

extension EnvironmentValues {
    var shuffleStackOffset: CGFloat {
        get { self[ShuffleStackOffsetKey.self] }
        set { self[ShuffleStackOffsetKey.self] = max(newValue, 0) }
    }
}

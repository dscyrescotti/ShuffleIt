import SwiftUI

struct ShuffleDisabledKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var shuffleDisabled: Bool {
        get { self[ShuffleDisabledKey.self] }
        set { self[ShuffleDisabledKey.self] = newValue }
    }
}

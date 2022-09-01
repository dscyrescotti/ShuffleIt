import SwiftUI

struct ShuffleStackStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: ShuffleStackStyle = .slide
}

extension EnvironmentValues {
    var shuffleStackStyle: ShuffleStackStyle {
        get { self[ShuffleStackStyleEnvironmentKey.self] }
        set { self[ShuffleStackStyleEnvironmentKey.self] = newValue }
    }
}

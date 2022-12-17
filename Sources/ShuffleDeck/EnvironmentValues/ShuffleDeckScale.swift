import SwiftUI

struct ShuffleDeckScaleKey: EnvironmentKey {
    static var defaultValue: CGFloat = 0.07
}

extension EnvironmentValues {
    var shuffleDeckScale: CGFloat {
        get { self[ShuffleDeckScaleKey.self] }
        set { self[ShuffleDeckScaleKey.self] = (min(1, max(0, newValue)) * 0.1) }
    }
}

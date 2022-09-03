import SwiftUI

struct StackScale: EnvironmentKey {
    static var defaultValue: CGFloat = 0.95
}

extension EnvironmentValues {
    var stackScale: CGFloat {
        get { self[StackScale.self] }
        set { self[StackScale.self] = (min(1, max(0, newValue)) * 0.1) + 0.9 }
    }
}

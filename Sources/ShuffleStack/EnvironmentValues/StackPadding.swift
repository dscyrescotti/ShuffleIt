import SwiftUI

struct StackPaddingKey: EnvironmentKey {
    static var defaultValue: CGFloat = 15
}

extension EnvironmentValues {
    var stackPadding: CGFloat {
        get { self[StackPaddingKey.self] }
        set { self[StackPaddingKey.self] = newValue }
    }
}

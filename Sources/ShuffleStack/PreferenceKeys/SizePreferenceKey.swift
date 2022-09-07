import SwiftUI

/// A perference key to reveal the size of child view.
struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue: Value = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

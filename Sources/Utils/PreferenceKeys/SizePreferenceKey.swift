import SwiftUI

/// A perference key to reveal the size of child view.
public struct SizePreferenceKey: PreferenceKey {
    public typealias Value = CGSize

    public static var defaultValue: Value = .zero

    public static func reduce(value: inout Value, nextValue: () -> Value) { }
}

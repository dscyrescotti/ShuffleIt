import SwiftUI

/*
 MARK: - Environment Values
 1. style - slide, rotateIn, rotateOut [done]
 2. auto shuffling
 3. shuffle to next (left/right)
 4. animation
 5. height
 6. default position = 15 [done]
 7. shuffle disable
*/

// MARK: - ShuffleStack
public struct ShuffleStack<Data: RandomAccessCollection, StackContent: View>: View where Data.Element: Identifiable, Data.Index == Int {
    // MARK: - Environments
    @Environment(\.shuffleStackStyle) internal var style
    
    // MARK: - States
    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: Direction = .left
    @State internal var isLockedLeft: Bool = false
    @State internal var isLockedRight: Bool = false
    @State internal var size: CGSize = .zero
    
    // MARK: - Properties
    internal let data: Data
    internal let stackContent: (Data.Element) -> StackContent
    
    public var body: some View {
        ZStack {
            Group {
                leftContent
                rightContent
                mainContent
            }
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: size.height)
        .onPreferenceChange(SizePreferenceKey.self) { size in
            DispatchQueue.main.async {
                self.size = size
            }
        }
    }
}

// MARK: - Initizer
extension ShuffleStack {
    public init(
        _ data: Data,
        initialIndex: Int = 0,
        @ViewBuilder stackContent: @escaping (Data.Element) -> StackContent
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex)
        self.stackContent = stackContent
    }
}

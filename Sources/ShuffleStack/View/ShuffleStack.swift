import SwiftUI

/*
 MARK: - Environment Values
 1. style - slide, rotateIn, rotateOut [done]
 2. auto shuffling
 3. shuffle to next (left/right)
 4. animation
 5. height
 6. default position = 15
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
    
    // MARK: - Properties
    internal let data: Data
    internal let stackContent: (Data.Element) -> StackContent
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                leftContent(proxy)
                rightContent(proxy)
                mainContent(proxy)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
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

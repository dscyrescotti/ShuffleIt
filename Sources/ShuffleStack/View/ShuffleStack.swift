import SwiftUI

// MARK: - ShuffleStack
public struct ShuffleStack<Data: RandomAccessCollection, StackContent: View>: View where Data.Element: Identifiable, Data.Index == Int {
    // MARK: - Environments
    @Environment(\.shuffleStyle) internal var style
    @Environment(\.shuffleAnimation) internal var animation
    @Environment(\.shuffleDisabled) internal var disabled
    @Environment(\.shuffleTrigger) internal var shuffleTrigger
    @Environment(\.stackOffset) internal var offset
    @Environment(\.stackScale) internal var scale
    @Environment(\.shuffleContext) internal var shuffleContext
    @Environment(\.shuffleTranslation) internal var shuffleTranslation
    
    // MARK: - States
    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: Direction = .left
    @State internal var isLockedLeft: Bool = false
    @State internal var isLockedRight: Bool = false
    @State internal var size: CGSize = .zero
    @State internal var autoShuffling: Bool = false
    
    // MARK: - GestureState
    @GestureState internal var isActiveGesture: Bool = false
    
    // MARK: - Properties
    internal let data: Data
    internal let stackContent: (Data.Element, CGFloat) -> StackContent
    
    public var body: some View {
        ZStack {
            Group {
                leftContent
                rightContent
                if disabled {
                    mainContent
                } else {
                    mainContent
                        .gesture(dragGesture)
                }
            }
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, offset)
        .frame(height: size.height)
        .onPreferenceChange(SizePreferenceKey.self) { size in
            DispatchQueue.main.async {
                self.size = size
            }
        }
        .onReceive(shuffleTrigger) { direction in
            if !autoShuffling && xPosition == 0 {
                performShuffling(direction)
            }
        }
        .onChange(of: xPosition) { position in
            shuffleTranslation?(abs(position) / size.width * 2)
        }
        .disabled(autoShuffling)
        .onChange(of: isActiveGesture) { value in
            if !isActiveGesture {
                performRestoring()
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
        self.stackContent = { element, _ in
            stackContent(element)
        }
    }
    
    public init(
        _ data: Data,
        initialIndex: Int = 0,
        @ViewBuilder stackContent: @escaping (Data.Element, CGFloat) -> StackContent
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex)
        self.stackContent = stackContent
    }
}

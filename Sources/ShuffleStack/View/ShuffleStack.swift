import SwiftUI

// MARK: - ShuffleStack
/// A stack view that provides shuffling behaviour to swipe contents to left and right.
///
/// `ShuffleStack` is built on top of `ZStack` but it only renders **three child views** which are visible on the screen and switches data to display based on the current index. As it renders three child views, it is **mandatory** to have **at least three elements** in data array. If not, it will end up with fatal error.
///
/// `ShuffleStack` comes with various type of modifiers to override default behaviour of the stack view so that it is easy to tailor to view with custom values such as animation, style, offset, padding and scale factor. Moreover, it also provides the way of listening shuffling events and programmatically shuffling contents.
///
/// The following example provide the simple usage of `ShuffleStack` which creates a stack of color cards with default shuffle style and animation.
///
/// ```
/// struct ContentView: View {
///     let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
///     var body: some View {
///         ShuffleStack(
///             colors,
///             initialIndex: 0
///         ) { color in
///             color
///                 .frame(height: 200)
///                 .cornerRadius(16)
///         }
///     }
/// }
/// ```
///
/// 
public struct ShuffleStack<Data: RandomAccessCollection, StackContent: View>: View where Data.Index == Int {
    // MARK: - Environments
    @Environment(\.shuffleStyle) internal var style
    @Environment(\.shuffleAnimation) internal var animation
    @Environment(\.shuffleDisabled) internal var disabled
    @Environment(\.shuffleTrigger) internal var shuffleTrigger
    @Environment(\.stackOffset) internal var offset
    @Environment(\.stackPadding) internal var padding
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
        .padding(.horizontal, padding + offset)
        .frame(minHeight: size.height)
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
    /// An initializer that returns an instance of `ShuffleStack`.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initial index of data for which content view will be rendered first.
    ///   - stackContent: A view builder that dynamically renders content view based on current index and data provided.
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
    
    /// An initializer that returns an instance of `ShuffleStack`.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initial index of data for which content view will be rendered first.
    ///   - stackContent: A view builder that dynamically renders content view based on current index and data provided. It also expose the translation value of how much view is been dragging while shuffling.
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

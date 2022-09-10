import SwiftUI
#if DEBUG
import ViewInspector
#endif

/// A stack view that provides shuffling behaviour to swipe contents to left and right.
///
/// ## Overview
/// `ShuffleStack` is built on top of `ZStack` but it only renders three child views which are visible on the screen and switches data to display based on the current index. As it renders three child views, it is mandatory to have at least three elements in data array. If not, it will end up with fatal error.
///
/// The following example provides the simple usage of `ShuffleStack` which creates a stack of color cards with default shuffle style and animation.
/// ```swift
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
/// ## Customizing default behaviours
/// `ShuffleStack` comes with various type of modifiers to override default behaviour of the stack view so that it is easy to tailor to view with custom values such as animation, style, offset, padding and scale factor.
///
/// The following table shows a list of available modifiers that customizes the view.
///
/// Modifier | Description
/// --- | ---
/// [`shuffleAnimation(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/shuffleanimation(_:)) | A modifer that override default shuffle animation of the shuffle stack view.
/// [`shuffleStyle(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/shufflestyle(_:)) | A modifer that override default shuffle style of the shuffle stack view.
/// [`stackOffset(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/stackoffset(_:)) | A modifier that sets value that is used to shift the offset of the upcoming and previous content views behind the view of the current index.
/// [`stackPadding(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/stackpadding(_:)) | A modifier that sets horizontal padding to the shuffle stack view.
/// [`stackScale(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/stackscale(_:)) | A modifier that sets scale factor to shrink the size of the upcoming and previous content views of stack.
/// [`swipeDisabled(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/swipedisabled(_:)) | A modifer that disables user interaction to shuffle content views.
///
/// ## Observing shuffle events and swiping translation
/// `ShuffleStack` provides handy modifiers that listens shuffle events and swiping translation to perform a particular action based on those values after shuffling succeeds or while swiping stack views.
///
/// The following modifiers helps to observe shuffling events and translation changes.
///
/// Modifier | Description
/// --- | ---
/// [`onShuffle(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/onshuffle(_:)) |  A modifier that listens shuffling events occurring on the shuffle stack view.
/// [`onTranslate(_:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/ontranslate(_:)) | A modifier that listens translation changes while swiping content views.
///
/// ## Triggering shuffling programmatically
/// `ShuffleStack` also allows programmatic shuffling by accpecting a series of events from the upstream publisher. Whenever the publisher fires an event, it block user interaction on the view and perform shuffling action.
/// Modifier | Description
/// --- | ---
/// [`shuffleTrigger(on:)`](https://dscyrescotti.github.io/ShuffleIt/documentation/shuffleit/shufflestack/shuffletrigger(on:)) | A modifier that accpets events of direction to perform programmatic shuffling.
///
/// ## Topics
/// ### Initializers
/// - ``init(_:initialIndex:stackContent:)-38nwt``
/// - ``init(_:initialIndex:stackContent:)-72j8b``
/// ### Instance Properties
/// - ``body``
/// ### Related
/// - ``Direction``
/// - ``ShuffleAnimation``
/// - ``ShuffleContext``
/// - ``ShuffleStyle``
public struct ShuffleStack<Data: RandomAccessCollection, StackContent: View>: View where Data.Index == Int {
    @Environment(\.shuffleStyle) internal var style
    @Environment(\.shuffleAnimation) internal var animation
    #if !os(tvOS)
    @Environment(\.shuffleDisabled) internal var disabled
    #endif
    @Environment(\.shuffleTrigger) internal var shuffleTrigger
    @Environment(\.stackOffset) internal var offset
    @Environment(\.stackPadding) internal var padding
    @Environment(\.stackScale) internal var scale
    @Environment(\.shuffleContext) internal var shuffleContext
    @Environment(\.shuffleTranslation) internal var shuffleTranslation
    
    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: Direction = .left
    @State internal var isLockedLeft: Bool = false
    @State internal var isLockedRight: Bool = false
    @State internal var size: CGSize = .zero
    @State internal var autoShuffling: Bool = false
    
    @GestureState internal var isActiveGesture: Bool = false
    
    internal let data: Data
    internal let stackContent: (Data.Element, CGFloat) -> StackContent
    
    #if DEBUG
    internal let inspection = Inspection<Self>()
    #endif
    
    public var body: some View {
        ZStack {
            Group {
                leftContent
                rightContent
                #if os(tvOS)
                mainContent
                #else
                if disabled {
                    mainContent
                } else {
                    mainContent
                        .gesture(dragGesture)
                }
                #endif
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
        #if DEBUG
        .onReceive(inspection.notice) {
            self.inspection.visit(self, $0)
        }
        #endif
    }
}

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
    
    /// An initializer that returns an instance of `ShuffleStack` and exposes translation value to child content through view builder.
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

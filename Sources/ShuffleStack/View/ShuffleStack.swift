import Utils
import SwiftUI
#if canImport(ViewInspector)
import UtilsForTest
import ViewInspector
#endif

/// A stack view that provides shuffling behaviour to swipe contents to left and right.
///
/// ## Overview
/// `ShuffleStack` is built on top of `ZStack` but it only renders three child views which are visible on the screen and switches data to display based on the current index. In case the data passed into the stack view is empty, there will be empty view on the screen.
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
/// ``shuffleAnimation(_:)`` | A modifer that overrides default shuffle animation of the shuffle stack view.
/// ``shuffleStyle(_:)`` | A modifer that overrides default shuffle style of the shuffle stack view.
/// ``shuffleOffset(_:)`` | A modifier that sets value that is used to shift the offset of the upcoming and previous content views behind the view of the current index.
/// ``shufflePadding(_:)`` | A modifier that sets horizontal padding to the shuffle stack view.
/// ``shuffleScale(_:)`` | A modifier that sets scale factor to shrink the size of the upcoming and previous content views of stack.
/// ``shuffleDisabled(_:)`` | A modifier that sets scale factor to shrink the size of the upcoming and previous content views of stack.
///
/// ## Observing shuffle events and swiping translation
/// `ShuffleStack` provides handy modifiers that listens shuffle events and swiping translation to perform a particular action based on those values after shuffling succeeds or while swiping stack views.
///
/// The following modifiers helps to observe shuffling events and translation changes.
///
/// Modifier | Description
/// --- | ---
/// ``onShuffle(_:)`` |  A modifier that listens shuffling events occurring on the shuffle stack view.
/// ``onShuffleTranslation(_:)`` | A modifier that listens translation changes while swiping content views.
///
/// ## Triggering shuffling programmatically
/// `ShuffleStack` also allows programmatic shuffling by accpecting a series of events from the upstream publisher. Whenever the publisher fires an event, it block user interaction on the view and perform shuffling action.
/// Modifier | Description
/// --- | ---
/// ``shuffleTrigger(on:)`` | A modifier that accpets events of direction to perform programmatic shuffling.
///
/// ## Topics
/// ### Initializers
/// - ``init(_:initialIndex:stackContent:)-38nwt``
/// - ``init(_:initialIndex:stackContent:)-72j8b``
/// ### Instance Properties
/// - ``body``
public struct ShuffleStack<Data: RandomAccessCollection, StackContent: View>: View {
    @Environment(\.shuffleStyle) internal var style
    @Environment(\.shuffleAnimation) internal var animation
    #if !os(tvOS)
    @Environment(\.shuffleDisabled) internal var disabled
    #endif
    @Environment(\.shuffleTrigger) internal var shuffleTrigger
    @Environment(\.shuffleOffset) internal var offset
    @Environment(\.shufflePadding) internal var padding
    @Environment(\.shuffleScale) internal var scale
    @Environment(\.shuffleContext) internal var shuffleContext
    @Environment(\.shuffleTranslation) internal var shuffleTranslation
    
    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: ShuffleDirection = .left
    @State internal var isLockedLeft: Bool = false
    @State internal var isLockedRight: Bool = false
    @State internal var size: CGSize = .zero
    @State internal var autoShuffling: Bool = false
    
    @GestureState internal var isActiveGesture: Bool = false
    
    internal let data: Data
    internal let stackContent: (Data.Element, CGFloat) -> StackContent
    
    #if canImport(ViewInspector)
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
            guard data.distance(from: data.startIndex, to: data.endIndex) > 1 else { return }
            if !autoShuffling && xPosition == 0 {
                performShuffling(direction)
            }
        }
        .onChange(of: xPosition) { position in
            DispatchQueue.main.async {
                shuffleTranslation?(abs(position) / size.width * 2)
            }
        }
        .disabled(autoShuffling)
        .onChange(of: isActiveGesture) { value in
            if !isActiveGesture {
                performRestoring()
            }
        }
        #if canImport(ViewInspector)
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
        initialIndex: Data.Index? = nil,
        @ViewBuilder stackContent: @escaping (Data.Element) -> StackContent
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex ?? data.startIndex)
        self.stackContent = { element, _ in
            stackContent(element)
        }
    }
    
    /// An initializer that returns an instance of `ShuffleStack` and exposes translation value to child content through view builder.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initial index of data for which content view will be rendered first.
    ///   - stackContent: A view builder that dynamically renders content view based on current index and data provided. It also exposes the translation value of how much view is been dragging while shuffling.
    public init(
        _ data: Data,
        initialIndex: Data.Index? =  nil,
        @ViewBuilder stackContent: @escaping (Data.Element, CGFloat) -> StackContent
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex ?? data.startIndex)
        self.stackContent = stackContent
    }
}

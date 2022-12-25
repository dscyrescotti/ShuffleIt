import Utils
import SwiftUI

/// A stack view providing shuffling behaviour to shuffle to left and right like a deck of cards.
///
/// ## Overview
/// `ShuffleDeck` is built on top of `ZStack` to mimic the shuffling behavior of a deck of cards. Like other stack views, it only renders the visible child views and switches data to display based on the current index. In case the data provided to the view is empty, there will be empty on the screen.
///
/// The following code snippet provides the usage of `ShuffleDeck` which creates a deck of cards with default shuffle style and animation.
///
/// ```swift
/// struct ContentView: View {
///     let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
///     var body: some View {
///         ShuffleDeck(
///             colors,
///             initialIndex: 0
///         ) { color in
///             color
///                 .frame(width: 200, height: 300)
///                 .cornerRadius(16)
///         }
///     }
/// }
/// ```
///
/// ## Tailoring default behaviours
/// `ShuffleDeck` comes with multiple modifiers to override default behaviour of the stack view so that it is easy to customize view with unique animation, style and scale factor.
///
/// The following table reveals a list of available modifiers that adjust the view as expected.
///
/// Modifier | Description
/// --- | ---
/// ``shuffleDeckAnimation(_:)`` | A modifier that overrides default shuffle animation of the shuffle deck view.
/// ``shuffleDeckDisabled(_:)`` | A modifier that disables user interaction to shuffle deck content views.
/// ``shuffleDeckScale(_:)`` | A modifier that sets scale factor to shrink the size of the left and right content views of shuffle deck view.
/// ``shuffleDeckStyle(_:)`` | A modifier that overrides default shuffle style of the shuffle deck view.
///
/// ## Monitoring shuffle events and translation
/// `ShuffleDeck` provides useful modifiers that listens shuffle events and shuffling translation to perform a particular action based on those values after shuffling succeeds or while shuffling deck view.
///
/// The following modifiers helps to observe shuffling events and translation changes.
///
/// Modifier | Decription
/// --- | ---
/// ``onShuffleDeck(_:)`` | A modifier that listens shuffling events occurring on the shuffle deck view.
/// ``onShuffleDeckTranslation(_:)`` | A modifier that listens translation changes while shuffling content views.
///
/// ## Triggering shuffling programmatically
/// `ShuffleDeck` also allows programmatic shuffling by accepting a series of events from the upstream publisher. Whenever the publisher fires an event, it blocks user interaction on the view and performs shuffling action.
///
/// Modifier | Description
/// --- | ---
/// ``shuffleDeckTrigger(on:)`` | A modifier that accepts events of direction to perform programmatic shuffling.
///
/// ## Topics
public struct ShuffleDeck<Data: RandomAccessCollection, Content: View>: View {
    @Environment(\.shuffleDeckStyle) internal var style
    @Environment(\.shuffleDeckScale) internal var scale
    @Environment(\.shuffleDeckAnimation) internal var animation
    @Environment(\.shuffleDeckTrigger) internal var shuffleDeckTrigger
    #if !os(tvOS)
    @Environment(\.shuffleDeckDisabled) internal var disabled
    #endif
    @Environment(\.shuffleDeckContext) internal var shuffleDeckContext
    @Environment(\.shuffleDeckTranslation) internal var shuffleDeckTranslation

    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var size: CGSize = .zero
    @State internal var direction: ShuffleDeckDirection = .left
    @State internal var autoShuffling: Bool = false

    @State internal var isLockedLeft = false
    @State internal var isLockedRight = false
    // MARK: - fourth content animation
    @State internal var isShiftedLeft = false
    @State internal var isShiftedRight = false

    @GestureState internal var isActiveGesture: Bool = false

    internal let data: Data
    internal let content: (Data.Element, CGFloat) -> Content

    public var body: some View {
        ZStack {
            // MARK: - Next Contents
            nextContent
            // MARK: - Left Contents
            fourthLeftContent
            thirdLeftContent
            secondLeftContent
            leftContent
            // MARK: - Right Contents
            fourthRightContent
            thirdRightContent
            secondRightContent
            rightContent
            // MARK: - Main Content
            mainContentView
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                }
        }
        .frame(maxWidth: .infinity, minHeight: size.height)
        .onPreferenceChange(SizePreferenceKey.self) { size in
            DispatchQueue.main.async {
                self.size = size
            }
        }
        .onChange(of: isActiveGesture) { value in
            if !isActiveGesture {
                performRestoring()
            }
        }
        .onReceive(shuffleDeckTrigger) { direction in
            switch style {
            case .infiniteShuffle:
                guard data.distance(from: data.startIndex, to: data.endIndex) > 1 else { return }
            case .finiteShuffle:
                switch direction {
                case .left:
                    guard data.startIndex != index else { return }
                case .right:
                    guard data.index(before: data.endIndex) != index else { return }
                }
            }
            if !autoShuffling && xPosition == 0 {
                performShuffling(direction)
            }
        }
        .disabled(autoShuffling)
        .onChange(of: xPosition) { _ in
            DispatchQueue.main.async {
                shuffleDeckTranslation?(translation)
            }
        }
    }

    @ViewBuilder
    var mainContentView: some View {
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
}

extension ShuffleDeck {
    /// An initializer that returns an instance of `ShuffleDeck`.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initial index of data for which content view will be rendered first.
    ///   - content: A view builder that dynamically renders content view based on current index and data provided.
    public init(
        _ data: Data,
        initialIndex: Data.Index? = nil,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex ?? data.startIndex)
        self.content = { element, _ in
            content(element)
        }
    }

    /// An initializer that returns an instance of `ShuffleDeck` and exposes translation value to child content through view builder.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initial index of data for which content view will be rendered first.
    ///   - content: A view builder that dynamically renders content view based on current index and data provided. It also exposes the translation value of how much view is been dragging while shuffling.
    public init(
        _ data: Data,
        initialIndex: Data.Index? = nil,
        content: @escaping (Data.Element, CGFloat) -> Content
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex ?? data.startIndex)
        self.content = content
    }
}

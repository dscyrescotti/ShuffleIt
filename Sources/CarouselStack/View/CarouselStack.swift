import Utils
import SwiftUI
#if canImport(UtilsForTest)
import UtilsForTest
import ViewInspector
#endif

/// A stack view which provides carousel-style sliding behaviour to slide contents to left and right.
///
/// ## Overview
/// `CarouselStack` is built on top of `ZStack` to renders carousel sliding view which only allocates at most five content views and reuses them when index changes. In case the data passed into the stack view is empty, there will be empty view on the screen.
///
/// The following code snippet demonstrates the simple usage of `CarouselStack` which creates a slide view of color cards with default carousel style and animation.
/// ```
/// struct ContentView: View {
///     let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
///     var body: some View {
///         CarouselStack(
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
/// `CarouselStack` provides a wide range of modifiers to override default behaviour of the stack view so that it is easy to tailor to view with custom values such as animation, style, spacing, padding and scale factor.
///
/// The following table shows a list of available modifiers that customizes the view.
///
/// Modifier | Description
/// --- | ---
/// ``carouselAnimation(_:)`` | A modifier that overrides default carousel animation of the carousel stack view.
/// ``carouselStyle(_:)`` | A modifer that overrides default carousel style of the carousel stack view.
/// ``carouselPadding(_:)`` | A modifier that sets horizontal padding to the carousel stack view.
/// ``carouselScale(_:)`` | A modifier that sets scale factor to shrink the size of the contents right next to the current content of the carousel stack view.
/// ``carouselSpacing(_:)`` | A modifier that sets value which is used to add some spacing between carousel stack contents.
/// ``carouselDisabled(_:)`` | A modifier that disables user interaction to carousel content views.
///
/// ## Observing sliding events and swiping translation
/// `CarouselStack` comes with useful modifiers that listens sliding events and swiping translation to perform a particular action based on those values after sliding succeeds or while swiping the views.
///
/// The following modifiers helps to observe sliding events and translation changes.
///
/// Modifier | Description
/// --- | ---
/// ``onCarousel(_:)`` | A modifier that listens sliding events occurring on the carousel stack view.
/// ``onCarouselTranslation(_:)`` | A modifier that listens translation changes while sliding content views.
///
/// ## Triggering the programmatic sliding
/// `CarouselStack` also allows programmatic sliding by accepting a series of events from the upstream publisher. Whenever the publisher fires an event, it blocks user interaction on the view and performs sliding action.
/// 
/// Modifier | Description
/// --- | ---
/// ``carouselTrigger(on:)`` | A modifier that accepts events of direction to perform programmatic sliding.
///
/// ## Topics
public struct CarouselStack<Data: RandomAccessCollection, Content: View>: View {
    @Environment(\.carouselStyle) internal var style
    @Environment(\.carouselAnimation) internal var animation
    #if !os(tvOS)
    @Environment(\.carouselDisabled) internal var disabled
    #endif
    @Environment(\.carouselTrigger) internal var carouselTrigger
    @Environment(\.carouselPadding) internal var padding
    @Environment(\.carouselSpacing) internal var spacing
    @Environment(\.carouselScale) internal var scale
    @Environment(\.carouselContext) internal var carouselContext
    @Environment(\.carouselTranslation) internal var carouselTranslation
    
    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: CarouselDirection = .left
    @State internal var size: CGSize = .zero
    @State internal var autoSliding: Bool = false
    
    @GestureState internal var isActiveGesture: Bool = false
    
    internal let data: Data
    internal let content: (Data.Element, CGFloat) -> Content
    
    #if canImport(UtilsForTest)
    internal let inspection = Inspection<Self>()
    #endif
    
    public var body: some View {
        ZStack {
            secondLeftContent
            leftContent
            contentView
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                }
            rightContent
            secondRightContent
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, padding)
        .frame(minHeight: size.height)
        .onPreferenceChange(SizePreferenceKey.self) { size in
            if size != .zero {
                DispatchQueue.main.async {
                    self.size = size
                }
            }
        }
        .onReceive(carouselTrigger) { direction in
            switch style {
            case .infiniteScroll:
                guard data.distance(from: data.startIndex, to: data.endIndex) > 1 else { return }
            case .finiteScroll:
                switch direction {
                case .left:
                    guard data.startIndex != index else { return }
                case .right:
                    guard data.index(before: data.endIndex) != index else { return }
                }
            }
            if !autoSliding && xPosition == 0 {
                performSliding(direction)
            }
        }
        .onChange(of: xPosition) { _ in
            DispatchQueue.main.async {
                carouselTranslation?(translation)
            }
        }
        .disabled(autoSliding)
        .onChange(of: isActiveGesture) { value in
            if !isActiveGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                    performRestoring()
                }
            }
        }
        #if canImport(UtilsForTest)
        .onReceive(inspection.notice) {
            self.inspection.visit(self, $0)
        }
        #endif
    }

    @ViewBuilder
    private var contentView: some View {
        #if os(tvOS)
        mainContent
        #else
        if disabled {
            mainContent
        } else {
            mainContent.gesture(dragGesture)
        }
        #endif
    }
}

extension CarouselStack {
    /// An initializer that returns an instance of `CarouselStack`.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initiai index of data for which content view will be rendered first.
    ///   - content: A view builder that dynamically renders content view based on current index and data provided.
    public init(
        _ data: Data,
        initialIndex: Data.Index? = nil,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = { element, _ in
            content(element)
        }
        self._index = State(initialValue: initialIndex ?? data.startIndex)
    }
    
    /// An initializer that returns an instance of `CarouselStack` and exposes translation value to child content through view builder.
    /// - Parameters:
    ///   - data: A collection of data that will be provided to content views through closure.
    ///   - initialIndex: An initial index of data for which content view will be rendered first.
    ///   - content: A view builder that dynamically renders content view based on current index and data provided. It also exposes the translation value of how much view is been dragging while sliding.
    public init(
        _ data: Data,
        initialIndex: Data.Index? = nil,
        @ViewBuilder content: @escaping (Data.Element, CGFloat) -> Content
    ) {
        self.data = data
        self.content = content
        self._index = State(initialValue: data.startIndex)
    }
}

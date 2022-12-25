import SwiftUI
import Combine

public extension View {
    /// A modifer that overrides default carousel style of the carousel stack view.
    ///
    /// `CarouselStack` provides two different carousel styles - `finiteScroll` (default) and `infiniteScroll`. To apply style as desired, it can be overridden with `carouselStyle(_:)` modifier.
    ///
    /// The following code snippet demonstrates how to override the carousel style to be able to scroll infinitely left and right.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselStyle(.infiniteScroll)
    /// }
    /// ```
    /// - Parameter style: A carousel style for carousel stack view.
    /// - Returns: A view with the given carousel style.
    func carouselStyle(_ style: CarouselStyle) -> some View {
        environment(\.carouselStyle, style)
    }
    
    /// A modifier that overrides default carousel animation of the carousel stack view.
    ///
    /// By default, `CarouselStack` comes with `linear` animation to animate scrolling behaviour. With `carouselAnimation(_:)` modifier, it can be overridden with the given animation value.
    ///
    /// The following example shows the usage of overriding default carousel animation with `easeInOut` animation that will be used while shuffling.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselAnimation(.easeInOut)
    /// }
    /// ```
    /// - Parameter animation: A shuffle animation for carousel stack view.
    /// - Returns: A view with the given carousel animation.
    func carouselAnimation(_ animation: CarouselAnimation) -> some View {
        environment(\.carouselAnimation, animation)
    }
    
    /// A modifier that disables user interaction to carousel content views.
    ///
    /// Based on the boolean passing into the modifier, the user interaction will be disabled accordingly. If the boolean is `true`, it will no longer turn on the interaction to UI. If the boolean is `false`, it allows to carousel content views.
    ///
    /// The following piece of code show how to disable the user interaction on the shuffle stack view.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselDisabled(false)
    /// }
    /// ```
    /// - Parameter disabled: A boolean value to decide whether it should be disabled or not.
    /// - Returns: A view with the given boolean.
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    func carouselDisabled(_ disabled: Bool) -> some View {
        environment(\.carouselDisabled, disabled)
    }
    
    /// A modifier that accepts events of direction to perform programmatic sliding.
    ///
    /// In purpose of programmatic sliding such as using timer, `CarouselStack` accepts events via `carouselTrigger(on:)` modifier which is needed to inject an instance of publisher with `CarouselDirection` output type and `Never` failure type.
    ///
    /// The following example provides the programmatic approach of triggering slide event by sending `CarouselDirection` value through the publisher.
    ///```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// let carouselPublisher = PassthroughSubject<CarouselDirection, Never>()
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselPublisher(on: carouselPublisher)
    /// }
    /// carouselPublisher.send(.left)
    /// carouselPublisher.send(.right)
    /// ```
    /// - Parameter publisher: A publisher object that fires `CarouselDirection` values.
    /// - Returns: A view with the given publisher object.
    func carouselTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == CarouselDirection, P.Failure == Never {
        environment(\.carouselTrigger, publisher.eraseToAnyPublisher())
    }
    
    /// A modifier that sets value which is used to add some spacing between carousel stack contents.
    ///
    /// To add spacing between carousel stack contents, it can be achieved by passing the value through `carouselSpacing(_:)` modifier. By default, it uses 10 pixels to make a gap between contents.
    ///
    /// The following code sample shows the usage of `carouselSpacing(_:)` modifier by adding the space of 15 pixels to see a gap between stack contents.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselSpacing(15)
    /// }
    /// ```
    /// - Parameter spacing: A spacing value between the content views of the carousel stack view.
    /// - Returns: A view with the given spacing.
    func carouselSpacing(_ spacing: CGFloat) -> some View {
        environment(\.carouselSpacing, spacing)
    }
    
    /// A modifier that sets horizontal padding to the carousel stack view.
    ///
    /// By default, `CarouselStack` come with 20 pixels to add extra space between its frame and its content views. To be overriden, it can be done by passing the desired padding value through `carouselPadding(_:)` modifier.
    ///
    /// The following code snippet shows the usage of `carouselPadding(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselPadding(15)
    /// }
    /// ```
    /// - Parameter padding: A padding value for a carousel stack view.
    /// - Returns: A view with the given padding.
    func carouselPadding(_ padding: CGFloat) -> some View {
        environment(\.carouselPadding, padding)
    }
    
    /// A modifier that sets scale factor to shrink the size of the contents right next to the current content of the carousel stack view.
    ///
    /// `CarouselStack` allows to scale up (set value above 1) and scale down (set value below 1) contents so that the desired ui can be achieved by passing the value through `carouselScale(_:)` modifier. By defaults, it comes with the value of 1.
    ///
    /// The following code snippet shows the usage of `carouselScale(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .carouselScale(1.2)
    /// }
    /// ```
    /// - Parameter scale: A scaling factor to shrink or enlarge the size of content views.
    /// - Returns: A view with the given scaling factor.
    func carouselScale(_ scale: CGFloat) -> some View {
        environment(\.carouselScale, scale)
    }
    
    /// A modifier that listens sliding events occurring on the carousel stack view.
    ///
    /// Using `onCarousel(_:)` modifier, it can be injected with a closure that exposes sliding information - `CarouselContext` through its parameter to perform a particular task whenever the user slides content views or sliding is executed programmatically.
    ///
    /// The following piece of code provides the usage of `onCarousel(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .onCarousel { (context: CarouselContext) in
    ///         /* some stuff */
    ///     }
    /// }
    /// ```
    /// - Parameter perform: A closure that exposes carousel context to perform everytime sliding occurs.
    /// - Returns: A view with the given action for side effect of sliding.
    func onCarousel(_ perform: @escaping (CarouselContext) -> Void) -> some View {
        environment(\.carouselContext, perform)
    }
    
    /// A modifier that listens translation changes while sliding content views.
    ///
    /// To listen translation value of content views while sliding, `onCarouselTranslation(_:)` modifier can be used by passing a closure in order to perform a specific task based on the translation value.
    ///
    /// The following example provides the usage of `onCarouselTranslation(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     CarouselStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .onCarouselTranslation { (translation: CGFloat) in
    ///         /* some stuff */
    ///     }
    /// }
    /// ```
    /// Besides, you can also directly listen translation value through the initializer instead of using this modifier.
    /// - Parameter perform: A closure that exposes translation changes while sliding.
    /// - Returns: A view with the given action to listen translation changes.
    func onCarouselTranslation(_ perform: @escaping (CGFloat) -> Void) -> some View {
        environment(\.carouselTranslation, perform)
    }
}

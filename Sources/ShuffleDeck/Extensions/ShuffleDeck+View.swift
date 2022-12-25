import SwiftUI
import Combine

public extension View {
    /// A modifier that overrides default shuffle animation of the shuffle deck view.
    ///
    /// By default, `ShuffleDeck` uses `linear` animation to animate shuffling behaviour. With `shuffleDeckAnimation` modifier, it can be overridden with the given animation value.
    ///
    /// The following example shows the usage of tailoring default shuffle deck animation with `easeIn` animation that will be used while shuffling.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleDeckAnimation(.easeIn)
    /// }
    /// ```
    /// - Parameter animation: A shuffle animation for shuffle deck view.
    /// - Returns: A view with the given shuffle deck animation.
    func shuffleDeckAnimation(_ animation: ShuffleDeckAnimation) -> some View {
        environment(\.shuffleDeckAnimation, animation)
    }

    /// A modifier that disables user interaction to shuffle deck content views.
    ///
    /// Based on the boolen passing into the modifier, the user interaction will be disabled accordingly, If the boolean is `true`, it will no longer turn on the interaction to UI. If the boolean is `false`, it allows to shuffle views.
    ///
    /// The following code snippet shows how to disable the user interaction on the shuffle deck view.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleDeckDisabled(false)
    /// }
    /// ```
    /// - Parameter disabled: A boolean value to decide whether it should be disabled or not.
    /// - Returns: A view with the given boolean.
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    func shuffleDeckDisabled(_ disabled: Bool) -> some View {
        environment(\.shuffleDeckDisabled, disabled)
    }

    /// A modifier that sets scale factor to shrink the size of the left and right content views of shuffle deck view.
    ///
    /// Regarding scaling content views, `ShuffleDeck` only allows to set value between 0 and 1 inclusively. If the value is out of this range, it will be replaced with 0 and 1 based on the given value. The default scaling factor is 0.7.
    ///
    /// The following code snippet shows the usage of `shuffleDeckScale(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleDeckScale(0.5)
    /// }
    /// ```
    /// - Parameter scale: A scaling factor to shrink the size of content views.
    /// - Returns: A view with the given scaling factor.
    func shuffleDeckScale(_ scale: CGFloat) -> some View {
        environment(\.shuffleDeckScale, scale)
    }

    /// A modifier that overrides default shuffle style of the shuffle deck view.
    ///
    /// `ShuffleDeck` comes with two different shuffling styles - `finiteShuffle` (default) and `infiniteShuffle`. To apply style as wanted, it can be overridden with `shuffleDeckStyle(_:)` modifier.
    ///
    /// The following code snippet demonstrates how to override the shuffle style to be able to shuffle infinitely.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleDeckStyle(.infiniteShuffle)
    /// }
    /// ```
    /// - Parameter style: A shuffle style for shuffle deck view.
    /// - Returns: A view with the given shuffle deck style.
    func shuffleDeckStyle(_ style: ShuffleDeckStyle) -> some View {
        environment(\.shuffleDeckStyle, style)
    }

    /// A modifier that accepts events of direction to perform programmatic shuffling.
    ///
    /// In purpose of programmatic shuffling using timer or manually, `ShuffleDeck` fires events via `shuffleDeckTrigger(on:)` modifier which is needed to inject an instance of publisher with `ShuffleDeckDirection` output type and `Never` failure type.
    ///
    /// The following example provides the programmatic approach of triggering shuffle event by sending `ShuffleDeckDirection` value through the publisher.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// let shuffleDeckPublisher = PassthroughSubject<ShuffleDeckDirection, Never>()
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleDeckTrigger(on: shuffleDeckPublisher)
    /// }
    /// shuffleDeckPublisher.send(.left)
    /// shuffleDeckPublisher.send(.right)
    /// ```
    /// - Parameter publisher: A publisher object that fires `ShuffleDeckDirection` values.
    /// - Returns: A view with the given publisher object.
    func shuffleDeckTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == ShuffleDeckDirection, P.Failure == Never {
        environment(\.shuffleDeckTrigger, publisher.eraseToAnyPublisher())
    }

    /// A modifier that listens shuffling events occurring on the shuffle deck view.
    ///
    /// Using `onShuffleDeck(_:)` modifier, it can inject a closure that exposes shuffling information - `ShuffleDeckContext` through its parameter to perform a particular task whenever the user shuffle content views or shuffling is triggered programmatically.
    ///
    /// The following piece of code provides the usage of `onShuffleDeck(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .onShuffleDeck { (context: ShuffleDeckContext) in
    ///         /* some stuff */
    ///     }
    /// }
    /// ```
    /// - Parameter perform: A closure that exposes shuffle deck context to perform everytime shuffling occurs.
    /// - Returns: A view with the given action for side effect of shuffling.
    func onShuffleDeck(_ perform: @escaping (ShuffleDeckContext) -> Void) -> some View {
        environment(\.shuffleDeckContext, perform)
    }

    /// A modifier that listens translation changes while shuffling content views.
    ///
    /// To listen translation value of content views, `onShuffleDeckTranslation(_:)` modifier can be used by passing a closure in order to perform a specific task based on the translation value.
    ///
    /// The following example provides the usage of `onShuffleDeckTranslation(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleDeck(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(width: 200, height: 300)
    ///             .cornerRadius(16)
    ///     }
    ///     .onShuffleDeckTranslation { (translation: CGFloat) in
    ///         /* some stuff */
    ///     }
    /// }
    /// ```
    /// Besides, you can also directly listen translation value through the view builder instead.
    /// - Parameter perform: A closure that exposes translation changes while shuffling.
    /// - Returns: A view with the given action to listen translation changes.
    func onShuffleDeckTranslation(_ perform: @escaping (CGFloat) -> Void) -> some View {
        environment(\.shuffleDeckTranslation, perform)
    }
}

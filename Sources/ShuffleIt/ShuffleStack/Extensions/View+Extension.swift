import SwiftUI
import Combine

public extension View {
    /// A modifer that override default shuffle style of the shuffle stack view.
    ///
    /// `ShuffleStack` comes with three different shuffle styles - `slide` (default), `rotateIn` and `rotateOut` and uses `slide` as a default style. To apply other style, it can be overriden by using `shuffleStyle(_:)` modifier.
    ///
    /// The following example show the usage of overriding default shuffle style with `rotateOut` style to rotate and scale to the outside while shuffling.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleStyle(.rotateOut)
    /// }
    /// ```
    /// - Parameter style: A shuffle style for shuffle stack view.
    /// - Returns: A view with the given shuffle style.
    func shuffleStyle(_ style: ShuffleStyle) -> some View {
        environment(\.shuffleStyle, style)
    }
    
    /// A modifer that override default shuffle animation of the shuffle stack view.
    ///
    /// As a default, `ShuffleStack` use `linear` animation to animate shuffling behaviour. With `shuffleAnimation(_:)` modifier, it can be overriden with the given animation value.
    ///
    /// The following example show the usage of overriding default shuffle animation with `easeInOut` animation that will be used while shuffling.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleAnimation(.easeInOut)
    /// }
    /// ```
    /// - Parameter animation: A shuffle animation for shuffle stack view.
    /// - Returns: A view with the given shuffle animation.
    func shuffleAnimation(_ animation: ShuffleAnimation) -> some View {
        environment(\.shuffleAnimation, animation)
    }
    
    /// A modifer that disables user interaction to shuffle content views.
    ///
    /// Based on the boolean passing into the modifier, the user interaction will be disabled accordingly. If the boolean is `true`,  it will no longer turn on the interaction to UI. If the boolean is `false`, it allows to shuffle content views.
    ///
    /// The following piece of code show how to disable the user interaction on the shuffle stack view.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .swipeDisabled(false)
    /// }
    /// ```
    /// - Parameter disabled: A boolean value to decide whether it should be disabled or not.
    /// - Returns: A view with the given boolean.
    func swipeDisabled(_ disabled: Bool) -> some View {
        environment(\.shuffleDisabled, disabled)
    }
    
    
    /// A modifier that accpets events of direction to perform programmatic shuffling.
    ///
    /// In purpose of shuffling programmatically such as using timer, `ShuffleStack` accepts events via `.shuffleTrigger(on:)` modifier which is needed to inject an instance of publisher with `Direction` output type and `Never` failure type.
    ///
    /// The following example provides the programmatic way of triggering shuffle event by sending `Direction` value through the publisher.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// let shufflePublisher = PassthroughSubject<Direction, Never>()
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .shuffleTrigger(on: shufflePublisher)
    /// }
    /// shufflePublisher.send(.left)
    /// shufflePublisher.send(.right)
    /// ```
    /// - Parameter publisher: A publisher object that fires `Direction` values.
    /// - Returns: A view with the given publisher object.
    func shuffleTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == Direction, P.Failure == Never {
        environment(\.shuffleTrigger, publisher.eraseToAnyPublisher())
    }
    
    /// A modifier that sets value that is used to shift the offset of the upcoming and previous content views behind the view of the current index.
    ///
    /// To shift the upcoming and previous content views of the shuffle stack view (not to overlay by the current view that display on the top of the stack), it can be adjust by setting offset value through `stackOffset(_:)` modifier. For default, it uses 15 pixels to shift the offset.
    ///
    /// The following code snippet shows the usage of `stackOffset(_:)` modifier. By using 25 pixels, it will be noticable that there is more horizontal gap between the upcoming and previous content views and the current view than using the default offset.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .stackOffset(25)
    /// }
    /// ```
    /// - Parameter offset: A offset value for the content views behind the current content view.
    /// - Returns: A view with the given offset.
    func stackOffset(_ offset: CGFloat) -> some View {
        environment(\.stackOffset, offset)
    }
    
    /// A modifier that sets horizontal padding to the shuffle stack view.
    ///
    /// For default, `ShuffleStack` uses 15 pixels to add extra space between its frame and its content views. To be overriden, it can be achieved by passing the desired padding value through `stackPadding(_:)` modifier.
    ///
    /// The following code snippet shows the usage of `stackPadding(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .stackPaddding(25)
    /// }
    /// ```
    /// - Parameter padding: A padding value for a shuffle stack view.
    /// - Returns: A view with the given padding.
    func stackPadding(_ padding: CGFloat) -> some View {
        environment(\.stackPadding, padding)
    }
    
    /// A modifier that sets scale factor to shrink the size of the upcoming and previous content views of stack.
    ///
    /// Regarding scaling content views, `ShuffleStack` only allows to set value between 0 and 1 inclusive. If the value is out of this range, it will be replaced with 0 or 1 based on the given value. The default scaling factor is 0.5.
    ///
    /// The following code snippet shows the usage of `stackScale(_:)` modifier.
    /// ```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .stackScale(0.6)
    /// }
    /// ```
    /// - Parameter scale: A scaling factor to shrink the size of content views.
    /// - Returns: A view with the given scaling factor.
    func stackScale(_ scale: CGFloat) -> some View {
        environment(\.stackScale, scale)
    }
    
    /// A modifier that listens shuffling events occurring on the shuffle stack view.
    ///
    /// Using `onShuffle(_:)` modifier, it can be injected wtih a closure that exposes shuffling information - `ShuffleContext` through its parameter to perform a particular task whenever the user swipe content views or trigger shuffling programmatically.
    ///
    /// The following example provides the usage of `onShuffle(_:)` modifier.
    ///```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .onShuffle { (context: ShuffleContext) in
    ///         /* some stuff */
    ///     }
    /// }
    /// ```
    /// - Parameter perform: a closure that exposes shuffle context to perform everytime shuffling happens.
    /// - Returns: A view with the given action for side effect of shuffling.
    func onShuffle(_ perform: @escaping (ShuffleContext) -> Void) -> some View {
        environment(\.shuffleContext, perform)
    }
    
    /// A modifier that listens translation changes while swiping content views.
    ///
    /// To listen translation value of content views while shuffling, `onTranslate(_:)` modifier can be used by passing a closure in order to perform a specific task based on the translation value.
    ///
    /// The following example provides the usage of `onTranslate(_:)` modifier.
    ///```swift
    /// let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    /// var body: some View {
    ///     ShuffleStack(
    ///         colors,
    ///         initialIndex: 0
    ///     ) { color in
    ///         color
    ///             .frame(height: 200)
    ///             .cornerRadius(16)
    ///     }
    ///     .onTranslate { (translation: CGFloat) in
    ///         /* some stuff */
    ///     }
    /// }
    /// ```
    /// Besides, you can also directly listen translation value through the initializer instead of using this modifier.
    /// - Parameter perform: a closure that exposes translation changes to perform while swiping.
    /// - Returns: A view with the given action to listen translation changes.
    func onTranslate(_ perform: @escaping (CGFloat) -> Void) -> some View {
        environment(\.shuffleTranslation, perform)
    }
}

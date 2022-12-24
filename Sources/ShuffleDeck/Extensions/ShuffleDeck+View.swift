import SwiftUI
import Combine

public extension View {
    func shuffleDeckStyle(_ style: ShuffleDeckStyle) -> some View {
        environment(\.shuffleDeckStyle, style)
    }

    func shuffleDeckAnimation(_ animation: ShuffleDeckAnimation) -> some View {
        environment(\.shuffleDeckAnimation, animation)
    }

    func shuffleDeckScale(_ scale: CGFloat) -> some View {
        environment(\.shuffleDeckScale, scale)
    }

    func shuffleDeckTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == ShuffleDeckDirection, P.Failure == Never {
        environment(\.shuffleDeckTrigger, publisher.eraseToAnyPublisher())
    }

    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    func shuffleDeckDisabled(_ disabled: Bool) -> some View {
        environment(\.shuffleDeckDisabled, disabled)
    }
}

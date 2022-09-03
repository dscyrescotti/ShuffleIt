import SwiftUI
import Combine

public extension View {
    func shuffleStyle(_ style: ShuffleStyle) -> some View {
        environment(\.shuffleStyle, style)
    }
    
    func shuffleAnimation(_ animation: ShuffleAnimation) -> some View {
        environment(\.shuffleAnimation, animation)
    }
    
    func swipeDisabled(_ disabled: Bool) -> some View {
        environment(\.shuffleDisabled, disabled)
    }
    
    func onShuffle<P: Publisher>(_ publisher: P) -> some View where P.Output == Direction, P.Failure == Never {
        environment(\.shuffleTrigger, publisher.eraseToAnyPublisher())
    }
    
    func shuffleStackOffset(_ offset: CGFloat) -> some View {
        environment(\.stackOffset, offset)
    }
}

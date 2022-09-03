import SwiftUI
import Combine

public extension View {
    func shuffleStackStyle(_ style: ShuffleStackStyle) -> some View {
        environment(\.shuffleStackStyle, style)
    }
    
    func shuffleStackAnimation(_ animation: ShuffleStackAnimation) -> some View {
        environment(\.shuffleStackAnimation, animation)
    }
    
    func swipeDisabled(_ disabled: Bool) -> some View {
        environment(\.swipeDisabled, disabled)
    }
    
    func onTriggerShuffling<P: Publisher>(_ publisher: P) -> some View where P.Output == Direction, P.Failure == Never {
        environment(\.shufflingPublisher, publisher.eraseToAnyPublisher())
    }
}

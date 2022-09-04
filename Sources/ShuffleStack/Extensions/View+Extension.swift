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
    
    func shuffleTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == Direction, P.Failure == Never {
        environment(\.shuffleTrigger, publisher.eraseToAnyPublisher())
    }
    
    func stackOffset(_ offset: CGFloat) -> some View {
        environment(\.stackOffset, offset)
    }
    
    func stackScale(_ scale: CGFloat) -> some View {
        environment(\.stackScale, scale)
    }
    
    func onShuffle(_ perform: @escaping (ShuffleContext) -> Void) -> some View {
        environment(\.shuffleContext, perform)
    }
    
    func onTranslate(_ perform: @escaping (CGFloat) -> Void) -> some View {
        environment(\.shuffleTranslation, perform)
    }
}

import SwiftUI

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
}

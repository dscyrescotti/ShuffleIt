import SwiftUI

public extension View {
    func shuffleStackStyle(_ style: ShuffleStackStyle) -> some View {
        environment(\.shuffleStackStyle, style)
    }
}

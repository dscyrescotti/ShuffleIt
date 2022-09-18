import SwiftUI
import Combine

public extension View {
    func carouselTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == CarouselDirection, P.Failure == Never {
        environment(\.carouselTrigger, publisher.eraseToAnyPublisher())
    }
}

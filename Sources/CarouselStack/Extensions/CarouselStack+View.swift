import SwiftUI
import Combine

public extension View {
    func carouselStyle(_ style: CarouselStyle) -> some View {
        environment(\.carouselStyle, style)
    }
    
    func carouselAnimation(_ animation: CarouselAnimation) -> some View {
        environment(\.carouselAnimation, animation)
    }
    
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
    @available(tvOS, unavailable)
    func carouselDisabled(_ disabled: Bool) -> some View {
        environment(\.carouselDisabled, disabled)
    }
    
    func carouselTrigger<P: Publisher>(on publisher: P) -> some View where P.Output == CarouselDirection, P.Failure == Never {
        environment(\.carouselTrigger, publisher.eraseToAnyPublisher())
    }
    
    func carouselSpacing(_ spacing: CGFloat) -> some View {
        environment(\.carouselSpacing, spacing)
    }
    
    func carouselPadding(_ padding: CGFloat) -> some View {
        environment(\.carouselPadding, padding)
    }
    
    func carouselScale(_ scale: CGFloat) -> some View {
        environment(\.carouselScale, scale)
    }
    
    func onCarousel(_ perform: @escaping (CarouselContext) -> Void) -> some View {
        environment(\.carouselContext, perform)
    }
    
    func onCarouselTranslation(_ perform: @escaping (CGFloat) -> Void) -> some View {
        environment(\.carouselTranslation, perform)
    }
}

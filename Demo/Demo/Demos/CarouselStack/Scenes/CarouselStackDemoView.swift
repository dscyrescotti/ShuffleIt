import SwiftUI
import Combine
import ShuffleIt

struct CarouselStackDemoView: View {
    let sneakers: [Sneaker] = .sneakers()
    let slideTrigger1 = PassthroughSubject<CarouselDirection, Never>()
    let slideTrigger2 = PassthroughSubject<CarouselDirection, Never>()
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Color.blue
                Color.cyan
            }
            VStack {
                CarouselStack(sneakers, initialIndex: 0) { sneaker in
                    SneakerCard(sneaker: sneaker, translation: 0)
                }
                .carouselScale(0.5)
                .carouselPadding(30)
                .carouselSpacing(20)
                .carouselTrigger(on: slideTrigger1)
                .onCarouselTranslation({ translation in
                    print(translation)
                })
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        slideTrigger1.send(.right)
                    }
                }
                CarouselStack(sneakers, initialIndex: 0) { sneaker in
                    SneakerCard(sneaker: sneaker, translation: 0)
                }
                .carouselScale(0.5)
                .carouselPadding(30)
                .carouselSpacing(20)
                .carouselTrigger(on: slideTrigger2)
                .onAppear {
                    slideTrigger2.send(.left)
                }
            }
        }
    }
}

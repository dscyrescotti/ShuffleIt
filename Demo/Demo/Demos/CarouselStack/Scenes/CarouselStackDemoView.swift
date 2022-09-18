import SwiftUI
import ShuffleIt

struct CarouselStackDemoView: View {
    let sneakers: [Sneaker] = .sneakers()
    var body: some View {
        CarouselStack(sneakers, initialIndex: 0) { sneaker in
            SneakerCard(sneaker: sneaker, translation: 0)
        }
    }
}

import SwiftUI

struct SneakerShuffleCard: View {
    let sneaker: Sneaker
    let translation: CGFloat
    var body: some View {
        VStack(spacing: 0) {
            Image(sneaker.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .rotationEffect(.degrees(-40 * Double(1 - translation)))
                .offset(x: -20 * Double(1 - translation))
            Text(sneaker.title)
                .font(.title.bold())
                .offset(y: -15)
                .padding(.bottom, -15)
            Text(sneaker.slogan)
                .font(.headline)
                .lineLimit(1)
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(hex: sneaker.theme.foreground))
        .background {
            GeometryReader { proxy in
                ZStack {
                    Circle()
                        .position(x: -30, y: 30)
                        .foregroundColor(Color(hex: sneaker.theme.secondary).opacity(0.6))
                    Circle()
                        .scale(1.3, anchor: .bottomTrailing)
                        .position(x: 250, y: proxy.size.height + 60)
                        .foregroundColor(Color(hex: sneaker.theme.primary).opacity(0.45))
                    Circle()
                        .scale(0.5)
                        .position(x: proxy.size.width, y: 60)
                        .foregroundColor(Color(hex: sneaker.theme.tertiary).opacity(0.6))
                }
                .blur(radius: 40)
            }
        }
        .background(Color(hex: sneaker.theme.background).opacity(0.4))
        .background(.white)
        .cornerRadius(16)
    }
}

struct SneakerShuffleCard_Previews: PreviewProvider {
    static var previews: some View {
        SneakerShuffleCard(
            sneaker: Sneaker(
                id: "air-trainer-sc-high",
                title: "Air Force 1",
                slogan: "To Air force, or not to the Air force.",
                imageName: "air-trainer-sc-high",
                theme: .init(
                    primary: "#FFBF85FF",
                    secondary: "#FFA490FF",
                    tertiary: "#FF7A00FF",
                    background: "#FFCFA3FF",
                    foreground: "#000000FF"
                ),
                items: []
            ),
            translation: 1
        )
        .foregroundColor(.white)
        .padding()
    }
}

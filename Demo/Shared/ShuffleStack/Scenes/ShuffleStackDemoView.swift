import Combine
import SwiftUI
import ShuffleStack

struct ShuffleStackDemoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var sneakers = loadSneakers()
    @State private var sneaker: Sneaker?
    @State private var isShowItems: Bool = false
    let shufflePublisher = PassthroughSubject<Direction, Never>()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let columns: [GridItem] = .init(repeating: GridItem(.flexible(), spacing: 20, alignment: .leading), count: 2)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ShuffleStack(sneakers) { sneaker, translation in
                SneakerShuffleCard(
                    sneaker: sneaker,
                    translation: abs(translation)
                )
            }
            .stackOffset(horizontalSizeClass == .compact ? 20 : 40)
            .stackScale(horizontalSizeClass == .compact ? 0.5 : 0.4)
            .stackPadding(20)
            .onShuffle { context in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isShowItems = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        sneaker = sneakers[context.index]
                        isShowItems = true
                    }
                }
            }
            .shuffleTrigger(on: shufflePublisher)
            .shuffleAnimation(.easeInOut)
            .shuffleStyle(horizontalSizeClass == .compact ? .rotateIn : .slide)
            if let sneaker = sneaker, isShowItems {
                Text("Explore in \(sneaker.title)")
                    .font(.title.bold())
                    .animation(.none)
                    .transition(AnyTransition.slide.combined(with: .opacity))
                    .padding(.horizontal, 20)
            }
            if let sneaker = sneaker, isShowItems {
                ScrollView {
                    Group {
                        if horizontalSizeClass == .compact {
                            LazyVStack(alignment: .leading) {
                                ForEach(sneaker.items) { item in
                                    SneakerItemRow(item: item)
                                }
                            }
                        } else {
                            LazyVGrid(columns: columns) {
                                ForEach(sneaker.items) { item in
                                    SneakerItemRow(item: item)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .animation(.none, value: sneaker.id)
                }
                .clipped()
                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
                .modifier(DragGestureViewModifier(onEnd: { value in
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                        shufflePublisher.send(.right)
                    case (0..., -30...30):
                        shufflePublisher.send(.left)
                    default: break
                    }
                }))
                .padding(.bottom, 20)
            } else {
                Spacer()
            }
        }
        .background {
            if let sneaker = sneaker {
                GeometryReader { proxy in
                    ZStack {
                        Circle()
                            .scale(1.1, anchor: .bottomTrailing)
                            .position(x: proxy.size.width, y: proxy.size.height / 2.5)
                            .foregroundColor(Color(hex: sneaker.theme.tertiary).opacity(0.3))
                        Circle()
                            .scale(0.7, anchor: .bottomTrailing)
                            .position(x: 0, y: proxy.size.height)
                            .foregroundColor(Color(hex: sneaker.theme.primary).opacity(0.45))
                    }
                    .blur(radius: 40)
                    .background(.white)
                    .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            sneaker = sneakers.first
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isShowItems = true
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .background {
                        Circle()
                            .foregroundColor(.black.opacity(0.4))
                            .padding(4)
                    }
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
        }
    }
    
    static func loadSneakers() -> [Sneaker] {
        guard let path = Bundle.main.url(forResource: "Sneakers", withExtension: "json"), let data = try? Data(contentsOf: path), let sneakers = try? JSONDecoder().decode([Sneaker].self, from: data) else { return [] }
        return sneakers
    }
}

struct ShuffleStackDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleStackDemoView()
    }
}

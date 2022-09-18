import SwiftUI

struct MainView: View {
    @State private var route: Route? = nil
    var body: some View {
        CarouselStackDemoView()
        /*
        NavigationView {
            List {
                Section {
                    Button(action: {
                        route = .shuffleStack
                    }) {
                        Label("ShuffleStack (Simple)", systemImage: "square.stack.3d.down.forward.fill")
                    }
                    Button(action: {
                        route = .timingShuffleStack
                    }) {
                        Label("ShuffleStack (with Timer)", systemImage: "deskclock.fill")
                    }
                    Button(action: {
                        route = .carouselStack
                    }) {
                        Label("CarouselStack", systemImage: "sparkles.rectangle.stack.fill")
                    }
                } header: {
                    Text("ShuffleStack")
                }

            }
            .listStyle(.insetGrouped)
            .foregroundColor(.black)
            .navigationTitle("ShuffleIt ✌️")
            .fullScreenCover(item: $route) { route in
                switch route {
                case .shuffleStack:
                    ShuffleStackDemoView()
                case .timingShuffleStack:
                    TimingShuffleStackDemoView()
                case .carouselStack:
                    CarouselStackDemoView()
                }
            }
        }
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum Route: Identifiable {
    case shuffleStack
    case timingShuffleStack
    case carouselStack
    
    var id: String {
        switch self {
        case .shuffleStack: return "shuffle-stack"
        case .timingShuffleStack: return "timing-shuffle-stack"
        case .carouselStack: return "carousel-stack"
        }
    }
}

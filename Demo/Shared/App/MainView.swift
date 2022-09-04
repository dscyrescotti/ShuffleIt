import SwiftUI

struct MainView: View {
    @State private var route: Route? = nil
    var body: some View {
        NavigationView {
            List {
                Button("ShuffleStack Demo") {
                    route = .shuffleStack
                }
            }
            .foregroundColor(.black)
            .navigationTitle("ShuffleIt ✌️")
            .fullScreenCover(item: $route) { route in
                switch route {
                case .shuffleStack:
                    ShuffleStackDemoView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum Route: Identifiable {
    case shuffleStack
    
    var id: String {
        switch self {
        case .shuffleStack: return "shuffle-stack"
        }
    }
}

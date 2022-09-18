import SwiftUI

public struct CarouselStack<Data: RandomAccessCollection, Content: View>: View {
    
    let padding: CGFloat = 40
    let spacing: CGFloat = 10
    
    @State internal var index: Data.Index
    
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: Direction = .left
    @State internal var size: CGSize = .zero
    
    @GestureState internal var isActiveGesture: Bool = false
    
    internal let data: Data
    internal let content: (Data.Element) -> Content
    
    public var body: some View {
        ZStack {
            Group {
                leftContent
                rightContent
                mainContent
            }
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, padding)
        .frame(minHeight: size.height)
        .onPreferenceChange(SizePreferenceKey.self) { size in
            DispatchQueue.main.async {
                self.size = size
            }
        }
        .onChange(of: isActiveGesture) { value in
            if !isActiveGesture {
                performRestoring()
            }
        }
        .gesture(dragGesture)
    }
}

extension CarouselStack {
    public init(
        _ data: Data,
        initialIndex: Data.Index,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
        self._index = State(initialValue: initialIndex)
    }
    
    public init(
        _ data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
        self._index = State(initialValue: data.startIndex)
    }
}

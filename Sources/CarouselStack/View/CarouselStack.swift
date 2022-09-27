import Utils
import SwiftUI

public struct CarouselStack<Data: RandomAccessCollection, Content: View>: View {
    
    @Environment(\.carouselStyle) internal var style
    @Environment(\.carouselAnimation) internal var animation
    #if !os(tvOS)
    @Environment(\.carouselDisabled) internal var disabled
    #endif
    @Environment(\.carouselTrigger) internal var carouselTrigger
    @Environment(\.carouselPadding) internal var padding
    @Environment(\.carouselSpacing) internal var spacing
    @Environment(\.carouselScale) internal var scale
    @Environment(\.carouselContext) internal var carouselContext
    @Environment(\.carouselTranslation) internal var carouselTranslation
    
    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var direction: CarouselDirection = .left
    @State internal var size: CGSize = .zero
    @State internal var autoSliding: Bool = false
    
    @GestureState internal var isActiveGesture: Bool = false
    
    internal let data: Data
    internal let content: (Data.Element) -> Content
    
    public var body: some View {
        carouselTranslation?(translation)
        return Group {
            #if os(tvOS)
            view
            #else
            if disabled {
                view
            } else {
                view.gesture(dragGesture)
            }
            #endif
        }
        .disabled(autoSliding)
    }
    
    private var view: some View {
        ZStack {
            Group {
                leftContent
                mainContent
                rightContent
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
        .onReceive(carouselTrigger) { direction in
            if !autoSliding && xPosition == 0 {
                performSliding(direction)
            }
        }
        .onChange(of: isActiveGesture) { value in
            if !isActiveGesture {
                performRestoring()
            }
        }
//        .onChange(of: xPosition) { _ in
//            carouselTranslation?(translation)
//        }
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

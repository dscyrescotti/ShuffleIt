import Utils
import SwiftUI

public struct ShuffleDeck<Data: RandomAccessCollection, Content: View>: View {
    @Environment(\.shuffleDeckStyle) internal var style
    @Environment(\.shuffleDeckScale) internal var scale
    @Environment(\.shuffleDeckAnimation) internal var animation
    @Environment(\.shuffleDeckTrigger) internal var shuffleDeckTrigger
    #if !os(tvOS)
    @Environment(\.shuffleDeckDisabled) internal var disabled
    #endif

    @State internal var index: Data.Index
    @State internal var xPosition: CGFloat = .zero
    @State internal var size: CGSize = .zero
    @State internal var direction: ShuffleDeckDirection = .left
    @State internal var autoShuffling: Bool = false

    @State internal var isLockedLeft = false
    @State internal var isLockedRight = false
    // MARK: - fourth content animation
    @State internal var isShiftedLeft = false
    @State internal var isShiftedRight = false

    @GestureState internal var isActiveGesture: Bool = false

    internal let data: Data
    internal let content: (Data.Element, CGFloat) -> Content

    public var body: some View {
        ZStack {
            // MARK: - Next Contents
            nextContent
            // MARK: - Left Contents
            fourthLeftContent
            thirdLeftContent
            secondLeftContent
            leftContent
            // MARK: - Right Contents
            fourthRightContent
            thirdRightContent
            secondRightContent
            rightContent
            // MARK: - Main Content
            mainContentView
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                }
        }
        .frame(maxWidth: .infinity, minHeight: size.height)
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
        .onReceive(shuffleDeckTrigger) { direction in
            switch style {
            case .infiniteShuffle:
                guard data.distance(from: data.startIndex, to: data.endIndex) > 1 else { return }
            case .finiteShuffle:
                switch direction {
                case .left:
                    guard data.startIndex != index else { return }
                case .right:
                    guard data.index(before: data.endIndex) != index else { return }
                }
            }
            if !autoShuffling && xPosition == 0 {
                performShuffling(direction)
            }
        }
    }

    @ViewBuilder
    var mainContentView: some View {
        #if os(tvOS)
        mainContent
        #else
        if disabled {
            mainContent
        } else {
            mainContent
                .gesture(dragGesture)
        }
        #endif
    }
}

extension ShuffleDeck {
    public init(
        _ data: Data,
        initialIndex: Data.Index? = nil,
        content: @escaping (Data.Element, CGFloat) -> Content
    ) {
        self.data = data
        self._index = State(initialValue: initialIndex ?? data.startIndex)
        self.content = content
    }
}

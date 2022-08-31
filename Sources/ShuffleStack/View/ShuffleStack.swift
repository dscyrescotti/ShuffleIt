import SwiftUI

/*
 MARK: - Environment Values
 1. style - default, rotateIn, rotateOut
 2. auto shuffling
 3. shuffle to next (left/right)
 4. animation
 5. height
*/

public struct ShuffleStack<Data: RandomAccessCollection, StackContent: View>: View where Data.Element: Identifiable, Data.Index == Int {
    @State private var index: Data.Index
    @State private var xPosition: CGFloat = .zero
    @State private var direction: Direction = .left
    @State private var isLockedLeft: Bool = false
    @State private var isLockedRight: Bool = false
    
    private let data: Data
    private let stackContent: (Data.Element) -> StackContent
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                stackContent(leftElement)
                    .offset(x: xPosition > 0 ? -15 - xPosition : -15, y: 0)
                    .scaleEffect(xPosition > 0 ? 1 : 0.95)
                    .rotation3DEffect(
                        xPosition > 0 ? .degrees(0 + Double(xPosition) / 15) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .zIndex(direction == .right ? 1 : 3)
                stackContent(rightElement)
                    .offset(x: xPosition < 0 ? 15 - xPosition : 15, y: 0)
                    .scaleEffect(xPosition < 0 ? 1 : 0.95)
                    .rotation3DEffect(
                        xPosition < 0 ? .degrees(0 + Double(xPosition) / 15) : .zero,
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .zIndex(direction == .left ? 1 : 3)
                stackContent(data[index])
                    .zIndex(4)
                    .offset(x: xPosition, y: 0)
                    .rotation3DEffect(
                        .degrees(0 + Double(-xPosition) / 15),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .gesture(dragGesture(proxy))
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
    
    private func dragGesture(_ proxy: GeometryProxy) -> some Gesture {
        DragGesture()
            .onChanged({ value in
                xPosition = value.translation.width / 2.3
                if xPosition > 0 {
                    direction = .left
                } else if xPosition < 0 {
                    direction = .right
                }
            })
            .onEnded({ value in
                let midX = proxy.size.width * 0.5
                if xPosition > 0 {
                    if xPosition < 100 {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = 0
                        }
                    } else {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = midX
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            xPosition = -xPosition
                            index = data.previousIndex(index, offset: 1)
                            direction = .right
                            isLockedLeft = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.linear(duration: 0.2)) {
                                xPosition = 0
                                isLockedLeft = false
                            }
                        }
                    }
                } else if xPosition < 0 {
                    if xPosition > -100 {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = 0
                        }
                    } else {
                        withAnimation(.linear(duration: 0.15)) {
                            xPosition = -midX
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            xPosition = -xPosition
                            index = data.nextIndex(index, offset: 1)
                            direction = .left
                            isLockedRight = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.linear(duration: 0.2)) {
                                xPosition = 0
                                isLockedRight = false
                            }
                        }
                        
                    }
                }
            })
    }
    
    private var leftElement: Data.Element {
        isLockedLeft ? data.nextElement(index, offset: 2) : data.previousElement(index, offset: 1)
    }
    
    private var rightElement: Data.Element {
        isLockedRight ? data.previousElement(index, offset: 2) : data.nextElement(index, offset: 1)
    }
}

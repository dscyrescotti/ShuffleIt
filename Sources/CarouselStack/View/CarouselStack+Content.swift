import SwiftUI

extension CarouselStack {
    @ViewBuilder
    internal var mainContent: some View {
        content(data[index])
            .offset(x: xPosition)
            .scaleEffect(xPosition == 0 ? 1 : max(scale, 1 - (scale + ((1 - scale) * scaleFactor) - scale)))
    }
    
    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement {
            content(element)
                .offset(x: xPosition - size.width - spacing)
                .scaleEffect(xPosition == 0 ? scale : min(scale + ((1 - scale) * scaleFactor), 1), anchor: .leading)
        }
    }
    
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement {
            content(element)
                .offset(x: xPosition + size.width + spacing)
                .scaleEffect(xPosition == 0 ? scale : min(scale + ((1 - scale) * scaleFactor), 1), anchor: .trailing)
        }
    }
}

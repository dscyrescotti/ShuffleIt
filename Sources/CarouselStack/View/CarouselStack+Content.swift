import SwiftUI

extension CarouselStack {
    /// A view that renders the content view for the element of the current index.
    @ViewBuilder
    internal var mainContent: some View {
        if let element = data[safe: index] {
            let scale = 1 - (1 - scale) * scaleFactor
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: mainOffset(on: scale))
        }
    }
    
    /// A view that renders the content view for the element of the previous index.
    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement(1) {
            let scale = scale + (1 - scale) * scaleFactor
            let scaledWidth = size.width * scale
            let offset = xPosition - size.width - spacing - (spacing * scaleFactor) + (size.width - scaledWidth) / 2
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    /// A view that renders the content view for the element of the next index.
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement(1) {
            let scale = scale + (1 - scale) * scaleFactor
            let scaledWidth = size.width * scale
            let offset = xPosition + size.width + spacing + (spacing * scaleFactor) - (size.width - scaledWidth) / 2
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    /// A view that renders the content view for the element of the second previous index.
    @ViewBuilder
    internal var secondLeftContent: some View {
        if let element = leftDataElement(2) {
            let scaledWidth = size.width * scale
            let offsetRight = xPosition - size.width - spacing - (spacing * scaleFactor) + (size.width - scaledWidth) / 2
            let offset = offsetRight - size.width - spacing * scaleFactor
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    /// A view that renders the content view for the element of the second next index.
    @ViewBuilder
    internal var secondRightContent: some View {
        if let element = rightDataElement(2) {
            let scaledWidth = size.width * scale
            let offsetRight = xPosition + size.width + spacing + (spacing * scaleFactor) - (size.width - scaledWidth) / 2
            let offset = offsetRight + size.width + spacing * scaleFactor
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    func mainOffset(on scale: CGFloat) -> CGFloat {
        let scaledWidth = size.width * scale
        let translation: CGFloat = scaleFactor > 0.5 ? (scaleFactor == 1 ? 0 : 0.5 - scaleFactor.truncatingRemainder(dividingBy: 0.5)) : scaleFactor
        if xPosition > 0 {
            return xPosition + (spacing * translation) - (spacing * scaleFactor) - (size.width - scaledWidth) / 2
        } else {
            return xPosition - (spacing * translation) + (spacing * scaleFactor) + (size.width - scaledWidth) / 2
        }
    }
}

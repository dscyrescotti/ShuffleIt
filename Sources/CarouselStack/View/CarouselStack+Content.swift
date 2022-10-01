import SwiftUI

extension CarouselStack {
    @ViewBuilder
    internal var mainContent: some View {
        let scale = 1 - (1 - scale) * scaleFactor
        content(data[index], translation)
            .scaleEffect(scale)
            .offset(x: mainOffset(on: scale))
    }
    
    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement {
            let scale = scale + (1 - scale) * scaleFactor
            let scaledWidth = size.width * scale
            let offset = xPosition - size.width - spacing - (spacing * scaleFactor) + (size.width - scaledWidth) / 2
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement {
            let scale = scale + (1 - scale) * scaleFactor
            let scaledWidth = size.width * scale
            let offset = xPosition + size.width + spacing + (spacing * scaleFactor) - (size.width - scaledWidth) / 2
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    @ViewBuilder
    internal var secondLeftContent: some View {
        if let element = secondLeftDataElement {
            let scaledWidth = size.width * scale
            let offsetRight = xPosition - size.width - spacing - (spacing * scaleFactor) + (size.width - scaledWidth) / 2
            let offset = offsetRight - size.width - spacing * scaleFactor
            content(element, translation)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    @ViewBuilder
    internal var secondRightContent: some View {
        if let element = secondRightDataElement {
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

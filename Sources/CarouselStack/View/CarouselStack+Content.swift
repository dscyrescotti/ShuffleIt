import SwiftUI

extension CarouselStack {
    @ViewBuilder
    internal var mainContent: some View {
        let scale = 1 - (1 - scale) * translation
        content(data[index])
            .scaleEffect(scale)
            .offset(x: mainOffset(on: scale))
    }
    
    func mainOffset(on scale: CGFloat) -> CGFloat {
        let scaledWidth = size.width * scale
        let translation: CGFloat = self.translation > 0.5 ? 0.5 - translation.truncatingRemainder(dividingBy: 0.5) : translation.truncatingRemainder(dividingBy: 0.5)
        if xPosition > 0 {
            return xPosition + (spacing * translation) - (spacing * self.translation) - (size.width - scaledWidth) / 2
        } else {
            return xPosition - (spacing * translation) + (spacing * self.translation) + (size.width - scaledWidth) / 2
        }
    }
    
    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement {
            let scale = scale + (1 - scale) * translation
            let scaledWidth = size.width * scale
            let offset = xPosition - size.width - spacing - (spacing * translation) + (size.width - scaledWidth) / 2
            content(element)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
    
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement {
            let scale = scale + (1 - scale) * translation
            let scaledWidth = size.width * scale
            let offset = xPosition + size.width + spacing + (spacing * translation) - (size.width - scaledWidth) / 2
            content(element)
                .scaleEffect(scale)
                .offset(x: offset)
        }
    }
}

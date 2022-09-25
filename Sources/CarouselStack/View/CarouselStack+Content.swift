import SwiftUI

extension CarouselStack {
    @ViewBuilder
    internal var mainContent: some View {
        content(data[index])
            .offset(x: xPosition)
    }
    
    @ViewBuilder
    internal var leftContent: some View {
        if let element = leftDataElement {
            let offset = xPosition - size.width - spacing
            content(element)
                .offset(x: offset)
        }
    }
    
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement {
            let offset = xPosition + size.width + spacing
            content(element)
                .offset(x: offset)
        }
    }
}

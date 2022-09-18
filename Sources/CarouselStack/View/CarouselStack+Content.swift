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
            content(element)
                .offset(x: xPosition - size.width - spacing)
        }
    }
    
    @ViewBuilder
    internal var rightContent: some View {
        if let element = rightDataElement {
            content(element)
                .offset(x: xPosition + size.width + spacing)
        }
    }
}

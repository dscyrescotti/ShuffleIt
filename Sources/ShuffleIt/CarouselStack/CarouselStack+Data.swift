import SwiftUI

extension CarouselStack {
    internal var leftDataElement: Data.Element? {
        data.previousElement(index, offset: 1)
    }
    
    internal var rightDataElement: Data.Element? {
        data.nextElement(index, offset: 1)
    }
}

import Utils
import SwiftUI

extension CarouselStack {
    internal var leftDataElement: Data.Element? {
        style == .infiniteScroll ? previousElement : previousElementNullable
    }
    
    internal var rightDataElement: Data.Element? {
        style == .infiniteScroll ? nextElement : nextElementNullable
    }
    
    internal var secondLeftDataElement: Data.Element? {
        style == .infiniteScroll ? previousElement2 : previousElementNullable2
    }
    
    internal var secondRightDataElement: Data.Element? {
        style == .infiniteScroll ? nextElement2 : nextElementNullable2
    }
    
    // MARK: - for infinite scroll
    internal var previousElement: Data.Element {
        data.previousElement(index, offset: 1)
    }
    
    internal var nextElement: Data.Element {
        data.nextElement(index, offset: 1)
    }
    
    internal var previousElement2: Data.Element {
        data.previousElement(index, offset: 2)
    }
    
    internal var nextElement2: Data.Element {
        data.nextElement(index, offset: 2)
    }
    
    internal var previousElementNullable: Data.Element? {
        data.previousElement(index, offset: 1)
    }
    
    internal var nextElementNullable: Data.Element? {
        data.nextElement(index, offset: 1)
    }
    
    internal var previousElementNullable2: Data.Element? {
        data.previousElement(index, offset: 2)
    }
    
    internal var nextElementNullable2: Data.Element? {
        data.nextElement(index, offset: 2)
    }
}

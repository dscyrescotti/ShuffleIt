import Utils
import SwiftUI

extension CarouselStack {
    /// A property that provides the upcoming element of left side.
    internal var leftDataElement: Data.Element? {
        style == .infiniteScroll ? previousElement : previousElementNullable
    }
    
    /// A property that provides the upcoming element of right side.
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
    internal var previousElement: Data.Element? {
        data.previousElement(forLoop: index, offset: 1)
    }
    
    internal var nextElement: Data.Element? {
        data.nextElement(forLoop: index, offset: 1)
    }
    
    internal var previousElement2: Data.Element? {
        data.previousElement(forLoop: index, offset: 2)
    }
    
    internal var nextElement2: Data.Element? {
        data.nextElement(forLoop: index, offset: 2)
    }
    
    // MARK: - for finite scroll
    internal var previousElementNullable: Data.Element? {
        data.previousElement(forUnloop: index, offset: 1)
    }
    
    internal var nextElementNullable: Data.Element? {
        data.nextElement(forUnloop: index, offset: 1)
    }
    
    internal var previousElementNullable2: Data.Element? {
        data.previousElement(forUnloop: index, offset: 2)
    }
    
    internal var nextElementNullable2: Data.Element? {
        data.nextElement(forUnloop: index, offset: 2)
    }
}

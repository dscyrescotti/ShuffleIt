import SwiftUI

extension ShuffleStack {
    /// A property that provides the upcoming element of left side.
    internal var leftDataElement: Data.Element {
        isLockedLeft ? data.nextElement(index, offset: 2) : data.previousElement(index, offset: 1)
    }
    
    /// A property that provides the upcoming element of right side.
    internal var rightDataElement: Data.Element {
        isLockedRight ? data.previousElement(index, offset: 2) : data.nextElement(index, offset: 1)
    }
}
